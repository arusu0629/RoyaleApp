//
//  DeckViewController.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

protocol DeckView: ShowErrorAlertView {
    func willFetchDecks()
    func didFetchDecks(decks: [DeckModel], selectedDeckIndex: Int)
    func didFailedFetchDecks(error: Error)

    func executeDeckShare(url: URL)
    func didUpdateSelectedDeck(currentDeck: DeckModel)

    // Ad
    func showFooterAdView()
    func hideFooterAdView()
}

// MARK: - Properties
final class DeckViewController: UIViewController {

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

    // Ad
    @IBOutlet private weak var footerAdView: FooterAdView!

    // Footer Spacer View
    @IBOutlet private weak var footerSpacerView: UIView! {
        willSet {
            newValue.isHidden = true
        }
    }
}

// MARK: - Life cycle
extension DeckViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
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

    func didUpdateSelectedDeck(currentDeck: DeckModel) {
        self.deckPreviewView.setup(currentDeck: currentDeck)
        self.deckDescritpionView.setup(currentDeck: currentDeck)
    }

    func showFooterAdView() {
        self.footerAdView.showLoading()
        AdManager.shared.setupAd(dataSource: self, delegate: self, targetView: self.footerAdView)
    }

    func hideFooterAdView() {
        self.footerAdView.isHidden = true
        self.footerSpacerView.isHidden = false
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

// MARK: - AdManagerDataSource
extension DeckViewController: AdManagerDataSource {

    public func currentViewController() -> UIViewController {
        return self
    }
}

// MARK: - AdManagerDelegate
extension DeckViewController: AdManagerDelegate {

    public func didReceiveAd() {
        self.footerAdView.hideLoading()
        self.footerAdView.isHidden = false
        self.footerSpacerView.isHidden = true
    }

    public func didFailedAd() {
        self.hideFooterAdView()
        self.footerAdView.hideLoading()
        self.footerSpacerView.isHidden = false
    }
}
