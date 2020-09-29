//
//  DeckCreateViewController.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 30/08/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

protocol DeckCreateView: ShowErrorAlertView {
    func willFetchDeckInfo()
    func didFetchCardSortType(cardSortType: CardSortType)
    func didFetchDeckInfo(playerModel: PlayerModel, currentDeck: DeckModel)
    func didFailedDeckInfo(error: Error)
    func didSortCards(cards: [CardModel], selectedCardList: [CardModel])
    func didClearSelectedCardList()
}

// MARK: - Properties
final class DeckCreateViewController: UIViewController {

    var presenter: DeckCreatePresenter!

    @IBOutlet private weak var cardSortView: CardSortView! {
        willSet {
            newValue.delegate = self
        }
    }
    @IBOutlet private weak var deckCreateListView: DeckCreateListView! {
        willSet {
            newValue.delegate = self
        }
    }
    @IBOutlet private weak var deckCreatePreviewView: DeckCreatePreviewView! {
        willSet {
            newValue.delegate = self
        }
    }
}

// MARK: - Life cycle
extension DeckCreateViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidload()
    }
}

// MARK: - DeckCreateView
extension DeckCreateViewController: DeckCreateView {

    func willFetchDeckInfo() {
        self.deckCreateListView.showLoading()
    }

    func didFetchCardSortType(cardSortType: CardSortType) {
        self.cardSortView.setSortType(cardSortType)
    }

    func didFetchDeckInfo(playerModel: PlayerModel, currentDeck: DeckModel) {
        self.deckCreateListView.setup(cardList: playerModel.cards, selectedCardList: currentDeck.cards)
        self.deckCreateListView.hideLoading()
        self.deckCreatePreviewView.setup(selectedCardList: currentDeck.cards)
        self.cardSortView.setup(cardFoundCount: playerModel.cards.count)
    }

    func didFailedDeckInfo(error: Error) {
        self.showErrorAlert(error)
    }

    func didSortCards(cards: [CardModel], selectedCardList: [CardModel]) {
        self.deckCreateListView.setup(cardList: cards, selectedCardList: selectedCardList)
    }

    func didClearSelectedCardList() {
        self.deckCreateListView.clearSelectedCardList()
        self.deckCreatePreviewView.clearSelectedCardList()
    }
}

// MARK: - User Interaction
extension DeckCreateViewController {

    @IBAction private func didTapDeckSelectButton() {
        self.presenter.didSelectDeckSelect()
    }

    @IBAction private func didTapDeckClearButton() {
        self.presenter.didSelectDeckClear()
    }
}

// MARK: - CardSortViewDelegate
extension DeckCreateViewController: CardSortViewDelegate {

    func didTapSortButton(sortType: CardSortType) {
        self.presenter.didSelectSortButton(sortType: sortType)
    }
}

// MARK: - DeckCreateListViewDelegate
extension DeckCreateViewController: DeckCreateListViewDelegate {

    func didUpdateSelectedCardList(selectedCardList: [CardModel]) {
        self.presenter.didUpdateSelectedCardList(selectedCardList)
        self.deckCreatePreviewView.setup(selectedCardList: selectedCardList)
    }
}

// MARK: - DeckCreatePreviewViewDelegate
extension DeckCreateViewController: DeckCreatePreviewViewDelegate {

    func didTapSelectedCard(cardModel: CardModel) {
        self.presenter.removeSelectedCard(cardModel)
        self.deckCreateListView.removeSelectedCard(cardModel)
    }
}
