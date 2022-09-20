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

    private let cardCollectionTitleLabelKey = "deck_create_card_collection_title_key"
    private let cardFoundTitleLabelKey      = "deck_create_card_found_title_key"

    @IBOutlet private weak var cardCollectionTitleLabel: UILabel! {
        willSet {
            newValue.text = self.cardCollectionTitleLabelKey.localized
        }
    }
    @IBOutlet private weak var cardFoundTitleLabel: UILabel! {
        willSet {
            newValue.text = self.cardFoundTitleLabelKey.localized
        }
    }

    @IBOutlet private weak var cardFoundLabel: UILabel!
    @IBOutlet private weak var sortButton: UIButton! {
        willSet {
            newValue.titleLabel?.minimumScaleFactor = 0.5
            newValue.titleLabel?.adjustsFontSizeToFitWidth = true
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

    func setup(cardFoundCount: Int) {
        self.cardFoundCount = cardFoundCount
    }

    func setSortType(_ sortType: CardSortType) {
        self.sortType = sortType
    }
}

// MARK: User Interaction
extension CardSortView {

    @IBAction private func didTapSort() {
        let nextSortType = CardSortType(rawValue: (self.sortType.rawValue + 1) % CardSortType.allCases.count) ?? .arena
        self.sortType = nextSortType
        SoundManager.shared.playSoundEffect(.selectSortButton)
        self.delegate?.didTapSortButton(sortType: self.sortType)
    }
}

// MARK: Card Sort Type
private extension CardSortType {

    var sortText: String {
        switch self {
        case .arena:            return "deck_create_sort_arena_title_key".localized
        case .elixir:           return "deck_create_sort_elixir_title_key".localized
        case .rarity:           return "deck_create_sort_rarity_title_key".localized
        case .rarityDescending: return "deck_create_sort_rarity_desc_title_key".localized
        case .level:            return "deck_create_sort_level_title_key".localized
        }
    }
}
