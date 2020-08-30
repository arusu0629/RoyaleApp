//
//  DeckPreviewView.swift
//  Presentation
//
//  Created by nakandakari on 2020/07/27.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import UIKit

final class DeckPreviewView: UIView {

    let sectionCount: Int = 2
    let itemsPerRow: Int = 4

    private var currentDeck: DeckModel = DeckModel()

    @IBOutlet private weak var deckPreviewCollectionView: UICollectionView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
            newValue.delaysContentTouches = false
            newValue.register(DeckPreviewCell.nib, forCellWithReuseIdentifier: DeckPreviewCell.className)
        }
    }
    @IBOutlet private weak var indicator: UIActivityIndicatorView!

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
}

extension DeckPreviewView {

    func setup(currentDeck: DeckModel) {
        self.currentDeck = currentDeck
        self.deckPreviewCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension DeckPreviewView: UICollectionViewDelegate {

}

// MARK: - UICollectionViewDataSource
extension DeckPreviewView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.sectionCount
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.itemsPerRow
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckPreviewCell.className, for: indexPath) as! DeckPreviewCell
        let index = (indexPath.section * self.itemsPerRow) + indexPath.row
        if index >= self.currentDeck.cards.count {
            cell.isHidden = true
        } else {
            cell.setData(iconUrl: self.currentDeck.cards[index].iconUrl)
            cell.isHidden = false
        }
        return cell
    }
}

extension DeckPreviewView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.resizeWithRatio(defaultCellSize: DeckPreviewCell.CellSize)
    }

    private func resizeWithRatio(defaultCellSize: CGSize) -> CGSize {
        let sideMargin: CGFloat = 2 * 2
        let cellSpacing: CGFloat = 2 * CGFloat(self.itemsPerRow - 1)
        let cellWidth: CGFloat = (self.deckPreviewCollectionView.bounds.width - sideMargin - cellSpacing) / CGFloat(self.itemsPerRow)
        let ratio: CGFloat =  cellWidth / defaultCellSize.width
        let cellHeight: CGFloat = defaultCellSize.height * ratio
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

// MARK: - Indicator
extension DeckPreviewView {

    func showLoading() {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
    }

    func hideLoading() {
        self.indicator.isHidden = true
        self.indicator.stopAnimating()
    }
}
