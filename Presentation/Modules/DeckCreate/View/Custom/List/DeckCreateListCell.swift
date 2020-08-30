//
//  DeckCreateListCell.swift
//  Presentation
//
//  Created by nakandakari on 2020/08/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import UIKit

final class DeckCreateListCell: UICollectionViewCell {

    static let CellSize = CGSize(width: 80, height: 96)

    @IBOutlet weak private var levelLabel: UILabel!
    @IBOutlet weak private var elixirLabel: UILabel!
    @IBOutlet weak private var iconImageView: UIImageView!

    @IBOutlet weak private var selectedView: UIView!
    @IBOutlet weak private var selectedNumberLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private var selectedNumber: Int = 0 {
        didSet {
            self.selectedView.isHidden = selectedNumber <= 0
            self.selectedNumberLabel.text = String(selectedNumber)
        }
    }
}

// MARK: - Setup
extension DeckCreateListCell {

    func setup(card: CardModel, selectedNumber: Int) {
        self.levelLabel.text = "level \(card.cardLevel)"
        self.elixirLabel.text = String(card.elixir)
        self.iconImageView.setImage(imageUrl: card.iconUrl)
        self.selectedNumber = selectedNumber
    }
}

// MARK: - Select/Deselct
extension DeckCreateListCell {

    func select(selectedNumber: Int) {
        self.selectedNumber = selectedNumber
    }

    func deselect() {
        self.selectedNumber = 0
    }
}

// MARK: - CardModel
private extension CardModel {

    // Rarity corrected level
    var cardLevel: Int {
        let cardMaster = CardMaster.shared
        return cardMaster.convertCardLevel(id: self.id, playerCardLevel: self.level)
    }

    var elixir: Int {
        let cardMaster = CardMaster.shared
        return cardMaster.getElixir(id: self.id)
    }
}
