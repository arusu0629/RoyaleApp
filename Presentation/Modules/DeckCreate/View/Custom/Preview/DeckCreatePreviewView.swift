//
//  DeckCreatePreviewView.swift
//  Presentation
//
//  Created by nakandakari on 2020/08/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import UIKit

protocol DeckCreatePreviewViewDelegate: AnyObject {
    func didTapSelectedCard(cardModel: CardModel)
}

final class DeckCreatePreviewView: UIView {

    let sectionCount: Int = 2
    let itemsPerRow: Int = 4

    @IBOutlet private weak var collectionView: UICollectionView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
            newValue.delaysContentTouches = false
            newValue.register(DeckCreatePreviewCell.nib, forCellWithReuseIdentifier: DeckCreatePreviewCell.className)
        }
    }

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

    private var selectedCardList: [CardModel] = []

    weak var delegate: DeckCreatePreviewViewDelegate?
}

// MARK: - Setup
extension DeckCreatePreviewView {

    func setup(selectedCardList: [CardModel]) {
        self.selectedCardList = selectedCardList
        self.collectionView.reloadData()
    }
}

// MARK: - Clear Selected Card List
extension DeckCreatePreviewView {

    func clearSelectedCardList() {
        self.selectedCardList = []
        self.collectionView.reloadData()
    }
}

// MARK: IndexPath -> SelectedCardIndex
extension DeckCreatePreviewView {

    private func selectedCardIndex(from indexPath: IndexPath) -> Int {
        return (indexPath.section * itemsPerRow) + indexPath.row
    }
}

// MARK: - UICollectionViewDelegate
extension DeckCreatePreviewView: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource
extension DeckCreatePreviewView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsPerRow
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckCreatePreviewCell.className, for: indexPath) as! DeckCreatePreviewCell
        let index = self.selectedCardIndex(from: indexPath)
        if index >= self.selectedCardList.count {
            cell.isHidden = true
        } else {
            cell.isHidden = false
            cell.setup(iconUrl: self.selectedCardList[index].iconUrl)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = self.selectedCardIndex(from: indexPath)
        let selectedCardModel = self.selectedCardList[index]
        self.selectedCardList.remove(at: index)
        self.collectionView.reloadData()
        self.delegate?.didTapSelectedCard(cardModel: selectedCardModel)
    }
}

extension DeckCreatePreviewView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.resizeWithRatio(defaultCellSize: DeckCreatePreviewCell.CellSize)
    }

    private func resizeWithRatio(defaultCellSize: CGSize) -> CGSize {
        let sideMargin: CGFloat = 2 * 2
        let cellSpacing: CGFloat = 2 * CGFloat(self.itemsPerRow - 1)
        let cellWidth: CGFloat = (self.collectionView.bounds.width - sideMargin - cellSpacing) / CGFloat(self.itemsPerRow)
        let ratio: CGFloat =  cellWidth / defaultCellSize.width
        let cellHeight: CGFloat = defaultCellSize.height * ratio
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
