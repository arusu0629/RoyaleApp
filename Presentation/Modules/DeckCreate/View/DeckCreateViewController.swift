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

    // Ad
    func showFooterAdView()
    func hideFooterAdView()
}

// MARK: - Properties
final class DeckCreateViewController: UIViewController {

    var presenter: DeckCreatePresenter!

    private let deckClearButtonTitleKey = "button_clear_title_key".localized
    private let deckOkButtonTitleKey    = "button_ok_title_key".localized

    private let multipleSelectedChampionsAlertMessageKey = "deck_create_multiple_champion_alert_message_key"

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

    @IBOutlet private weak var deckClearButton: UIButton! {
        willSet {
            newValue.setTitle(self.deckClearButtonTitleKey.localized, for: .normal)
        }
    }
    @IBOutlet private weak var deckOkButton: UIButton! {
        willSet {
            newValue.setTitle(self.deckOkButtonTitleKey.localized, for: .normal)
        }
    }

    // Ad
    @IBOutlet private weak var footerAdView: FooterAdView!
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

    // Ad
    func showFooterAdView() {
        self.footerAdView.showLoading()
        AdManager.shared.setupAd(dataSource: self, delegate: self, targetView: self.footerAdView)
    }

    func hideFooterAdView() {
        self.footerAdView.isHidden = true
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

    func didSelectMultipleChampionsCard() {
        let error = DeckCreateError.multipleSelectChampion(errorDescription: self.multipleSelectedChampionsAlertMessageKey.localized)
        self.showErrorAlert(error)
    }
}

// MARK: - DeckCreatePreviewViewDelegate
extension DeckCreateViewController: DeckCreatePreviewViewDelegate {

    func didTapSelectedCard(cardModel: CardModel) {
        self.presenter.removeSelectedCard(cardModel)
        self.deckCreateListView.removeSelectedCard(cardModel)
    }
}

// MARK: -
extension DeckCreateViewController: AdManagerDataSource {

    public func currentViewController() -> UIViewController {
        return self
    }
}

// MARK: - AdManagerDelegate
extension DeckCreateViewController: AdManagerDelegate {

    public func didReceiveAd() {
        self.footerAdView.hideLoading()
        self.footerAdView.isHidden = false
    }

    public func didFailedAd() {
        self.hideFooterAdView()
        self.footerAdView.hideLoading()
    }
}
