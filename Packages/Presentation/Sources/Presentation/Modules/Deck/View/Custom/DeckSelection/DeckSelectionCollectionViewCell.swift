//
//  DeckSelectionCollectionViewCell.swift
//  Presentation
//
//  Created by nakandakari on 2020/08/31.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

final class DeckSelectionCollectionViewCell: UICollectionViewCell {

    static let CellSize = CGSize(width: 40, height: 40)

    @IBOutlet private weak var label: UILabel!

    private var index = 0
    private var hasSelected = false

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: - Setup
extension DeckSelectionCollectionViewCell {

    func setup(index: Int, hasSelected: Bool) {
        self.index = index
        self.label.text = String(index + 1)

        self.hasSelected = hasSelected
        if self.hasSelected {
            self.select()
        } else {
            self.deselect()
        }
    }
}

// MARK: - User Interaction
extension DeckSelectionCollectionViewCell {

    func select() {
        self.label.borderColor = .white
        self.label.backgroundColor = .systemYellow
    }

    func deselect() {
        self.label.borderColor = .black
        self.label.backgroundColor = .systemGray2
    }
}
