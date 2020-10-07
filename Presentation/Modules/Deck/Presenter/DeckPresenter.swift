//
//  DeckPresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Analytics
import Domain
import Foundation

protocol DeckPresenter: AnyObject {

    // LifeCycle
    func viewDidLoad()

    func didSelectDeckCreate()
    func didSelectDeckChange()
    func didSelectDeckShare()
    func didSelectDeckIndex(_ index: Int)
}

final class DeckPresenterImpl: DeckPresenter {

    weak var view: DeckView?
    var wireframe: DeckWireframe!

    var playerUserCase: PlayerUseCase!
    var realmDeckModelUseCase: RealmDeckModelUseCase!

    private var selectedDeckIndex: Int = 0 {
        didSet {
            AppConfig.lastSelectedDeckIndex = self.selectedDeckIndex
        }
    }
    private var decks: [DeckModel] = []
    private var currentDeck: DeckModel {
        if self.decks.count <= self.selectedDeckIndex {
            return DeckModel()
        }
        return self.decks[selectedDeckIndex]
    }
}

// MARK: - DeckPresenter
extension DeckPresenterImpl {

    func viewDidLoad() {
        AnalyticsManager.sendEvent(DeckEvent.display)
        self.view?.showFooterAdView()
        self.selectedDeckIndex = AppConfig.lastSelectedDeckIndex
        self.getDeckModel()
    }

    func didSelectDeckCreate() {
        AnalyticsManager.sendEvent(DeckEvent.selectCreateDeck)
        self.selectedDeckIndex = self.decks.count
        self.wireframe.presentDeckCreate(deckIndex: self.selectedDeckIndex, selectedCardList: self.currentDeck.cards, dismissCompletion: {
            self.getDeckModel()
        })
    }

    func didSelectDeckChange() {
        AnalyticsManager.sendEvent(DeckEvent.selectChangeDeck)
        self.wireframe.presentDeckCreate(deckIndex: self.selectedDeckIndex, selectedCardList: self.currentDeck.cards, dismissCompletion: {
            self.getDeckModel()
        })
    }

    func didSelectDeckShare() {
        if let error = self.canDeckShare(deck: self.currentDeck) {
            self.view?.failedToDeckShare(error: error)
            return
        }
        guard let url = DeckMaster.shared.createDeckShareUrl(currentDeck: self.currentDeck) else {
            self.view?.failedToDeckShare(error: DeckShareError.invalidURL)
            return
        }
        AnalyticsManager.sendEvent(DeckEvent.selectShareDeck(deck: self.currentDeck))
        self.view?.executeDeckShare(url: url)
    }

    func didSelectDeckIndex(_ index: Int) {
        self.selectedDeckIndex = index
        self.view?.didUpdateSelectedDeck(currentDeck: self.currentDeck)
    }
}

// MARK: - Get DeckModel
extension DeckPresenterImpl {

    func getDeckModel() {
        self.view?.willFetchDecks()
        guard let deckModel = self.realmDeckModelUseCase.get() else {
            self.decks = []
            self.view?.didFetchDecks(decks: self.decks, selectedDeckIndex: self.selectedDeckIndex)
            return
        }
        let realmDeckModel = [RealmDeckModel](deckModel).filter { $0.playerTag == AppConfig.playerTag }

        self.playerUserCase.get(playerTag: AppConfig.playerTag) { result in
            switch result {
            case .success(let playerModel):
                self.decks = realmDeckModel.map { $0.convertToDeckModel(cards: playerModel.cards) }
                self.view?.didFetchDecks(decks: self.decks, selectedDeckIndex: self.selectedDeckIndex)
            case .failure(let error):
                self.view?.didFailedFetchDecks(error: error)
            }
        }
    }
}

// MARK: - DeckShare
extension DeckPresenterImpl {

    func canDeckShare(deck: DeckModel) -> Error? {
        if deck.cards.count != 8 {
            return DeckShareError.invalidCardCount
        }
        if self.hasDuplicatedCard(cards: deck.cards) {
            return DeckShareError.duplication
        }
        return nil
    }

    private func hasDuplicatedCard(cards: [CardModel]) -> Bool {
        var cardIds = Set<Int>()
        for card in cards {
            if cardIds.contains(card.id) {
                return true
            }
            cardIds.insert(card.id)
        }
        return false
    }
}
