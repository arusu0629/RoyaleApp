//
//  DeckDescriptionView.swift
//  Presentation
//
//  Created by nakandakari on 2020/09/04.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import UIKit

final class DeckDescriptionView: UIView {

    private let deckAverageElixirTitleKey = "deck_average_elixir_title_key"
    private let deckFourCardCycleTitleKey = "deck_four_card_cycle_title_key"

    @IBOutlet private weak var descriptionStackView: UIStackView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!

    @IBOutlet private weak var averageElixirTitleLabel: UILabel! {
        willSet {
            newValue.text = self.deckAverageElixirTitleKey.localized
        }
    }
    @IBOutlet private weak var averageElixirLabel: UILabel!

    @IBOutlet private weak var fourCardCycleElixirTitleLabel: UILabel! {
        willSet {
            newValue.text = self.deckFourCardCycleTitleKey.localized
        }
    }
    @IBOutlet private weak var fourCardCycleElixirLabel: UILabel!

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
extension DeckDescriptionView {

    func setup(currentDeck: DeckModel) {
        self.averageElixirLabel.text = String(currentDeck.averageElixir)
        self.fourCardCycleElixirLabel.text = String(currentDeck.fourCardCycleElixir)
    }
}

// MARK: - Extension DeckModel
private extension DeckModel {

    var averageElixir: Float {
        if self.cards.isEmpty {
            return 0.0
        }
        let elixirSum = self.cards
            .map { CardMaster.shared.getElixir(id: $0.id) }
            .reduce(0) { $0 + $1 }
        let average = Float(elixirSum) / Float(self.cards.count)
        // Rounded off to the second decimal place.
        return roundf(average * 10.0) / 10.0
    }

    var fourCardCycleElixir: Int {
        let cardMaster = CardMaster.shared
        var sortedElixirs = self.cards.sorted(by: {
            return cardMaster.getElixir(id: $0.id) < cardMaster.getElixir(id: $1.id)
        }).map({ cardMaster.getElixir(id: $0.id) })

        if sortedElixirs.count > 4 {
            sortedElixirs.removeSubrange(4..<sortedElixirs.count)
        }
        return sortedElixirs.reduce(0) { $0 + $1 }
    }
}

// MARK: - Indicator
extension DeckDescriptionView {

    func showLoading() {
        self.descriptionStackView.isHidden = true
        self.indicator.isHidden = false
        self.indicator.startAnimating()
    }

    func hideLoading() {
        self.indicator.isHidden = true
        self.indicator.stopAnimating()
        self.descriptionStackView.isHidden = false
    }
}

// MARK: - Refresh text
extension DeckDescriptionView {

    func refreshText() {
        self.averageElixirTitleLabel.text       = self.deckAverageElixirTitleKey.localized
        self.fourCardCycleElixirTitleLabel.text = self.deckFourCardCycleTitleKey.localized
    }
}
