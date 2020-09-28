//
//  DeckViewController.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

protocol DeckView: AnyObject {
    func willFetchDecks()
    func didFetchDecks(decks: [DeckModel], selectedDeckIndex: Int)
    func didFailedFetchDecks(error: Error)

    func executeDeckShare(url: URL)
    func failedToDeckShare(error: Error)
    func didUpdateSelectedDeck(currentDeck: DeckModel)
}

// MARK: - Properties
final class DeckViewController: UIViewController, ShowErrorAlertView {

    var presenter: DeckPresenter!

    private var decks: [DeckModel] = []
    private var selectedDeckIndex: Int = 0

    private var currentDeck: DeckModel {
        if self.decks.isEmpty || self.selectedDeckIndex < 0 || self.decks.count <= self.selectedDeckIndex {
            return DeckModel()
        }
        return self.decks[self.selectedDeckIndex]
    }

    @IBOutlet private weak var deckSelectionView: DeckSelectionView! {
        willSet {
            newValue.delegate = self
        }
    }
    @IBOutlet private weak var deckPreviewView: DeckPreviewView!
    @IBOutlet private weak var deckDescritpionView: DeckDescriptionView!
}

// MARK: - Life cycle
extension DeckViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
}

// MARK: - DeckView
extension DeckViewController: DeckView {

    func willFetchDecks() {
        self.deckPreviewView.showLoading()
        self.deckDescritpionView.showLoading()
    }

    func didFetchDecks(decks: [DeckModel], selectedDeckIndex: Int) {
        self.decks = decks
        self.selectedDeckIndex = selectedDeckIndex
        self.deckPreviewView.setup(currentDeck: self.currentDeck)
        self.deckPreviewView.hideLoading()
        self.deckSelectionView.setup(deckCount: self.decks.count, lastSelectedDeckIndex: self.selectedDeckIndex)
        self.deckDescritpionView.setup(currentDeck: self.currentDeck)
        self.deckDescritpionView.hideLoading()
    }

    func didFailedFetchDecks(error: Error) {
        self.showErrorAlert(error)
        self.deckPreviewView.hideLoading()
        self.deckDescritpionView.hideLoading()
    }

    func executeDeckShare(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            self.showErrorAlert(DeckShareError.invalidURL)
        }
    }

    func failedToDeckShare(error: Error) {
        self.showErrorAlert(error)
    }

    func didUpdateSelectedDeck(currentDeck: DeckModel) {
        self.deckPreviewView.setup(currentDeck: currentDeck)
        self.deckDescritpionView.setup(currentDeck: currentDeck)
    }
}

// MARK: Deck Create/Change/Share
extension DeckViewController {

    @IBAction private func didTapDeckCreate() {
        self.presenter.didSelectDeckCreate()
    }

    @IBAction private func didTapDeckChange() {
        self.presenter.didSelectDeckChange()
    }

    @IBAction private func didTapDeckShare() {
        self.presenter.didSelectDeckShare()
    }
}

// MARK: - DeckSelectionViewDelegate
extension DeckViewController: DeckSelectionViewDelegate {

    func didSelected(index: Int) {
        self.presenter.didSelectDeckIndex(index)
    }
}
