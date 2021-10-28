//
//  DeckCreateCollectionView.swift
//  Presentation
//
//  Created by nakandakari on 2020/08/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import UIKit

protocol DeckCreateListViewDelegate: AnyObject {
    func didUpdateSelectedCardList(selectedCardList: [CardModel])
    func didSelectMultipleChampionsCard()
}

final class DeckCreateListView: UIView {

    let maxCardCountPerDeck = 8
    let itemsPerRow: Int = 4

    private var cardList: [CardModel] = []
    private var selectedCardList: [CardModel] = []

    @IBOutlet weak private var deckCardCollectionView: UICollectionView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
            newValue.delaysContentTouches = false
            newValue.register(DeckCreateListCell.nib, forCellWithReuseIdentifier: DeckCreateListCell.className)
        }
    }

    @IBOutlet weak private var indicator: UIActivityIndicatorView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    private func initialize() {
        self.loadXib()
    }

    private var willReloadIndexPathList: [IndexPath] = []

    weak var delegate: DeckCreateListViewDelegate?
}

// MARK: - Setup
extension DeckCreateListView {

    func setup(cardList: [CardModel], selectedCardList: [CardModel]) {
        self.cardList = cardList
        self.selectedCardList = selectedCardList
        self.deckCardCollectionView.reloadData()
    }
}

// MARK: - Clear/Remove SelectedCard
extension DeckCreateListView {

    func clearSelectedCardList() {
        self.selectedCardList = []
        self.deckCardCollectionView.reloadData()
    }

    func removeSelectedCard(_ selectedCard: CardModel) {
        guard let index = self.selectedCardList.firstIndex(where: { $0.id == selectedCard.id }) else {
            return
        }
        self.selectedCardList.remove(at: index)
        self.deckCardCollectionView.reloadData()
    }

}

// MARK: - UICollectionViewDataSource
extension DeckCreateListView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let section = ceil(Double(cardList.count) / Double(self.itemsPerRow))
        return Int(section)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsPerRow
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckCreateListCell.className, for: indexPath) as! DeckCreateListCell

        let cardIndex = self.cardIndex(from: indexPath)
        if cardIndex < 0 {
            cell.isHidden = true
            return cell
        }

        let cardData = self.cardList[cardIndex]
        cell.setup(card: cardData, selectedNumber: self.selectedCardNumber(indexPath: indexPath))
        cell.isHidden = false
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckCreateListCell.className, for: indexPath) as! DeckCreateListCell

        let cardIndex = self.cardIndex(from: indexPath)
        if cardIndex < 0 {
            return
        }

        // already selected, do deselct
        if let selectedIndex = self.selectedCardList.firstIndex(where: { $0.id == self.cardList[cardIndex].id }) {
            cell.deselect()
            self.selectedCardList.remove(at: selectedIndex)
            self.willReloadIndexPathList = self.indexPathList(from: self.selectedCardList)
            self.willReloadIndexPathList.append(indexPath)
        } else {
            if self.selectedCardList.count >= self.maxCardCountPerDeck {
                return
            }
            // TODO: リファクタリング
            // チャンピオンを複数選択した場合はアラート表示
            let willSelectCardRarity = CardMaster.shared.getRarity(id: self.cardList[cardIndex].id)
            let alreadySelectedChampionsCount = self.selectedCardList
                .map { $0.id }
                .filter {
                    switch CardMaster.shared.getRarity(id: $0) {
                    case .champion:
                        return true
                    default:
                        return false
                    }
                }
                .count
            if case .champion = willSelectCardRarity, alreadySelectedChampionsCount > 0 {
                self.delegate?.didSelectMultipleChampionsCard()
                return
            }
            self.selectedCardList.append(self.cardList[cardIndex])
            cell.select(selectedNumber: self.selectedCardList.count)
            self.willReloadIndexPathList = self.indexPathList(from: self.selectedCardList)
        }

        SoundManager.shared.playSoundEffect(.selectCell)
        self.delegate?.didUpdateSelectedCardList(selectedCardList: self.selectedCardList)
    }

    private func selectedCardNumber(indexPath: IndexPath) -> Int {
        let cardIndex = self.cardIndex(from: indexPath)
        if cardIndex < 0 {
            return 0
        }
        if let index = self.selectedCardList.firstIndex(where: { $0.id == self.cardList[cardIndex].id }) {
            return index + 1
        }
        return 0
    }

    private func selectedIndexPathListToCardList(_ selectedIndexPathList: [IndexPath]) -> [CardModel] {
        return selectedIndexPathList.map { self.cardList[($0.section * self.itemsPerRow) + $0.row] }
    }

    private func cardIndex(from indexPath: IndexPath) -> Int {
        let cardIndex = indexPath.section * self.itemsPerRow + indexPath.row
        if self.cardList.count <= cardIndex {
            return -1
        }
        return cardIndex
    }

    private func indexPath(from card: CardModel) -> IndexPath? {
        guard let cardIndex = self.cardList.firstIndex(where: { $0.id == card.id }) else {
            return nil
        }

        let section = Int(floor(Double(cardIndex) / Double(self.itemsPerRow)))
        let row = cardIndex % self.itemsPerRow
        return IndexPath(row: row, section: section)
    }

    private func indexPathList(from cards: [CardModel]) -> [IndexPath] {
        let indexPathList = cards.compactMap { self.indexPath(from: $0) }
        return indexPathList
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DeckCreateListView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.resizeWithRatio(defaultCellSize: DeckCreateListCell.CellSize)
    }

    private func resizeWithRatio(defaultCellSize: CGSize) -> CGSize {
        let sideMargin: CGFloat = 2 * 2
        let cellSpacing: CGFloat = 2 * CGFloat(self.itemsPerRow - 1)
        let cellWidth: CGFloat = (self.deckCardCollectionView.bounds.width - sideMargin - cellSpacing) / CGFloat(self.itemsPerRow)
        let ratio: CGFloat =  cellWidth / defaultCellSize.width
        let cellHeight: CGFloat = defaultCellSize.height * ratio
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: - HoverCollectionViewCellDelegate
extension DeckCreateListView: HoverCollectionViewCellDelegate {

    func didFinishTapAnimation() {
        self.deckCardCollectionView.reloadItems(at: self.willReloadIndexPathList)

        self.willReloadIndexPathList = []
    }
}

// MARK: - Indicator
extension DeckCreateListView {

    func showLoading() {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
    }

    func hideLoading() {
        self.indicator.isHidden = true
        self.indicator.stopAnimating()
    }
}
