//
//  DeckCreatePresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 30/08/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Analytics
import Domain
import Foundation

protocol DeckCreatePresenter: AnyObject {

    // LifeCycle
    func viewDidload()

    // User Interaction
    func didSelectDeckSelect()
    func didSelectDeckClear()
    func didSelectSortButton(sortType: CardSortType)
    func didUpdateSelectedCardList(_ selectedCardList: [CardModel])
    func removeSelectedCard(_ selectedCard: CardModel)
}

final class DeckCreatePresenterImpl: DeckCreatePresenter {

    weak var view: DeckCreateView?
    var wireframe: DeckCreateWireframe!

    var playerUseCase: PlayerUseCase!
    var realmDeckModelUseCase: RealmDeckModelUseCase!

    private var selectedDeckIndex: Int = 0
    private var sortType: CardSortType = .arena
    private var selectedCardList: [CardModel] = []

    private var playerModel: PlayerModel?

    init(deckIndex: Int, selectedCardList: [CardModel]) {
        self.selectedDeckIndex = deckIndex
        self.selectedCardList = selectedCardList
        self.sortType = CardSortType(rawValue: AppConfig.lastSelectedSortIndex) ?? .arena
    }
}

// MARK: DeckCreatePresenter
extension DeckCreatePresenterImpl {

    func viewDidload() {
        AnalyticsManager.sendEvent(DeckCreateEvent.display)
        self.getDeckInfo()
    }

    func didSelectDeckSelect() {
        let deck = DeckModel(cards: self.selectedCardList)
        AnalyticsManager.sendEvent(DeckCreateEvent.selectDeckSelect(deck: deck))
        self.realmDeckModelUseCase.save(object: RealmDeckModel.create(playerTag: AppConfig.playerTag, index: self.selectedDeckIndex, name: "テスト", deckModel: deck))
        self.wireframe.dismiss(completion: nil)
    }

    func didSelectDeckClear() {
        AnalyticsManager.sendEvent(DeckCreateEvent.selectClear)
        self.selectedCardList = []
        self.view?.didClearSelectedCardList()
    }

    func didSelectSortButton(sortType: CardSortType) {
        AnalyticsManager.sendEvent(DeckCreateEvent.selectCardSort(cardSortType: sortType))
        self.sortType = sortType
        AppConfig.lastSelectedSortIndex = self.sortType.rawValue
        self.sortCards(sortType: self.sortType)
    }

    func didUpdateSelectedCardList(_ selectedCardList: [CardModel]) {
        self.selectedCardList = selectedCardList
    }

    func removeSelectedCard(_ selectedCard: CardModel) {
        guard let index = self.selectedCardList.firstIndex(where: { $0.id == selectedCard.id }) else {
            return
        }
        self.selectedCardList.remove(at: index)
    }
}

// MARK: - Get Deck Info
extension DeckCreatePresenterImpl {

    private func getDeckInfo() {
        self.view?.willFetchDeckInfo()
        self.getPlayerInfo { result in
            switch result {
            case .success(let playerModel):
                self.playerModel = playerModel
                self.playerModel!.cards = self.sortType.sort(cards: self.playerModel!.cards)
                self.getSelectedDeckInfo(playerModel: self.playerModel!)
            case .failure(let error):
                self.view?.didFailedDeckInfo(error: error)
            }
        }
    }

    private func getSelectedDeckInfo(playerModel: PlayerModel) {
        guard let realmDeckModel = self.realmDeckModelUseCase.get() else {
            self.view?.didFetchDeckInfo(playerModel: playerModel, currentDeck: DeckModel())
            return
        }

        let playerDeckModel = [RealmDeckModel](realmDeckModel).filter { $0.playerTag == AppConfig.playerTag }
        if let selectedDeckModel = playerDeckModel.first(where: { $0.index == self.selectedDeckIndex }) {
            self.view?.didFetchDeckInfo(playerModel: playerModel, currentDeck: selectedDeckModel.convertToDeckModel(cards: playerModel.cards))
        } else {
            self.view?.didFetchDeckInfo(playerModel: playerModel, currentDeck: DeckModel())
        }
    }

    private func getPlayerInfo(completion: @escaping (Result<PlayerModel, Error>) -> Void) {
        self.playerUseCase.get(playerTag: AppConfig.playerTag) { result in
            switch result {
            case .success(let playerModel):
                completion(.success(playerModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - Sort Card
extension DeckCreatePresenterImpl {

    private func sortCards(sortType: CardSortType) {
        guard let playerCards = self.playerModel?.cards else {
            self.view?.didSortCards(cards: [], selectedCardList: self.selectedCardList)
            return
        }
        let sortedCards = self.sortType.sort(cards: playerCards)
        self.playerModel!.cards = sortedCards
        self.view?.didSortCards(cards: sortedCards, selectedCardList: self.selectedCardList)
    }
}

private extension CardSortType {

    func sort(cards: [CardModel]) -> [CardModel] {
        switch self {
        case .arena:
            let cardMaster = CardMaster.shared
            let arenaSortedCards = cards.sorted(by: {
                let arenaA = cardMaster.getArena(id: $0.id); let arenaB = cardMaster.getArena(id: $1.id)
                return (arenaA == arenaB) ? $0.id < $1.id : arenaA < arenaB
            })
            return arenaSortedCards
        case .elixir:
            let cardMaster = CardMaster.shared
            let elixirSortedCards = cards.sorted(by: {
                let elixirA = cardMaster.getElixir(id: $0.id); let elixirB = cardMaster.getElixir(id: $1.id)
                return (elixirA == elixirB) ? $0.id < $1.id : elixirA < elixirB
            })
            return elixirSortedCards
        case .rarity:
            return self.sortByRarity(cards: cards, desc: false)
        case .rarityDescending:
            return self.sortByRarity(cards: cards, desc: true)
        case .level:
            let cardMaster = CardMaster.shared
            let levelSortedCards = cards.sorted(by: {
                let levelA = cardMaster.convertCardLevel(id: $0.id, playerCardLevel: $0.level)
                let levelB = cardMaster.convertCardLevel(id: $1.id, playerCardLevel: $1.level)
                return (levelA == levelB) ? $0.id < $1.id : levelA > levelB
            })
            return levelSortedCards
        }
    }

    private func sortByRarity(cards: [CardModel], desc: Bool) -> [CardModel] {
        let cardMaster = CardMaster.shared
        let raritySortedCards = cards.sorted(by: {
            let rarityA = cardMaster.getRarity(id: $0.id); let rarityB = cardMaster.getRarity(id: $1.id)
            if rarityA.rawValue == rarityB.rawValue {
                return $0.id < $1.id
            }
            return desc ? (rarityA.rawValue > rarityB.rawValue) : (rarityA.rawValue < rarityB.rawValue)
        })
        return raritySortedCards
    }
}
