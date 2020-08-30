//
//  CardSortView.swift
//  Presentation
//
//  Created by nakandakari on 2020/09/03.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import UIKit

protocol CardSortViewDelegate: AnyObject {
    func didTapSortButton(sortType: CardSortType)
}

final class CardSortView: UIView {

    @IBOutlet private weak var cardFoundLabel: UILabel!
    @IBOutlet private weak var sortButton: UIButton!

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

    private var cardFoundCount: Int = 0 {
        didSet {
            self.cardFoundLabel.text = String(self.cardFoundCount)
        }
    }

    private var sortType: CardSortType = .arena {
        didSet {
            self.sortButton.setTitle(self.sortType.sortText, for: .normal)
        }
    }

    weak var delegate: CardSortViewDelegate?
}

// MARK: - Setup
extension CardSortView {

    func setup(cardFoundCount: Int, sortType: CardSortType) {
        self.cardFoundCount = cardFoundCount
        self.sortType = sortType
    }
}

// MARK: User Interaction
extension CardSortView {

    @IBAction private func didTapSort() {
        let nextSortType = CardSortType(rawValue: (self.sortType.rawValue + 1) % CardSortType.allCases.count) ?? .arena
        self.sortType = nextSortType
        self.delegate?.didTapSortButton(sortType: self.sortType)
    }
}

// MARK: Card Sort Type
private extension CardSortType {

    var sortText: String {
        switch self {
        case .arena:            return "Arena"
        case .elixir:           return "Elixir"
        case .rarity:           return "Rarity"
        case .rarityDescending: return "Rarity(desc)"
        case .level:            return "Level"
        }
    }
}
