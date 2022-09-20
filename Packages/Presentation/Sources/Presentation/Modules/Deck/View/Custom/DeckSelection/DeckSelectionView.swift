//
//  DeckSelectionView.swift
//  Presentation
//
//  Created by nakandakari on 2020/08/31.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import UIKit

protocol DeckSelectionViewDelegate: AnyObject {
    func didSelected(index: Int)
}

final class DeckSelectionView: UIView {

    @IBOutlet private weak var collectionView: UICollectionView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
            newValue.delaysContentTouches = false
            newValue.register(DeckSelectionCollectionViewCell.nib, forCellWithReuseIdentifier: DeckSelectionCollectionViewCell.className)
        }
    }

    private var deckCount: Int = 0
    private var lastSelectedDeckIndex: Int = 0

    weak var delegate: DeckSelectionViewDelegate?

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

// MARK: - Setup
extension DeckSelectionView {

    func setup(deckCount: Int, lastSelectedDeckIndex: Int) {
        self.deckCount = deckCount
        self.lastSelectedDeckIndex = lastSelectedDeckIndex
        //        self.updateCollectionViewFlowLayout()
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension DeckSelectionView: UICollectionViewDelegate {}

// MARK: - UICollectionViewDataSource
extension DeckSelectionView: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.deckCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckSelectionCollectionViewCell.className, for: indexPath) as! DeckSelectionCollectionViewCell
        cell.setup(index: indexPath.row, hasSelected: self.lastSelectedDeckIndex == indexPath.row)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckSelectionCollectionViewCell.className, for: indexPath) as! DeckSelectionCollectionViewCell
        cell.select()

        // will update cell list
        var reloadIndexPathList = [indexPath]

        // last selected cell
        let lastSelectedIndexPath = IndexPath(row: self.lastSelectedDeckIndex, section: 0)
        let lastSelectedCell = collectionView.dequeueReusableCell(withReuseIdentifier: DeckSelectionCollectionViewCell.className, for: lastSelectedIndexPath) as! DeckSelectionCollectionViewCell
        lastSelectedCell.deselect()
        reloadIndexPathList.append(lastSelectedIndexPath)

        self.lastSelectedDeckIndex = indexPath.row

        // reload cell
        self.collectionView.reloadItems(at: reloadIndexPathList)

        SoundManager.shared.playSoundEffect(.selectTab)
        self.delegate?.didSelected(index: indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DeckSelectionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return DeckSelectionCollectionViewCell.CellSize
    }
}
