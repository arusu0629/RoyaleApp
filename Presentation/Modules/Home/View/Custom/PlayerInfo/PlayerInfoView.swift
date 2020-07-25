//
//  PlayerInfoView.swift
//  Presentation
//
//  Created by nakandakari on 2020/07/02.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import Foundation
import UIKit

final class PlayerInfoView: UIView {

    @IBOutlet private weak var nameAndTagLabel: UILabel! {
        willSet {
            newValue.isHidden = true
        }
    }
    @IBOutlet private weak var clanLabel: UILabel! {
        willSet {
            newValue.isHidden = true
        }
    }
    @IBOutlet private weak var trophyLabel: UILabel! {
        willSet {
            newValue.isHidden = true
        }
    }
    @IBOutlet private weak var trophyImageView: UIImageView! {
        willSet {
            newValue.isHidden = true
        }
    }
    @IBOutlet private weak var indicator: UIActivityIndicatorView! {
        willSet {
            newValue.isHidden = true
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
}

// MARK: - Setup
extension PlayerInfoView {

    func setup(playerModel: PlayerModel) {
        self.nameAndTagLabel.text = playerModel.name + " " + playerModel.tag
        self.nameAndTagLabel.isHidden = false
        self.clanLabel.text = playerModel.clanName
        self.clanLabel.isHidden = false
    }

    func setupTrophy(trophy: Int) {
        self.trophyLabel.text = String(trophy)
        self.trophyLabel.isHidden = false
        self.trophyImageView.isHidden = false
    }
}

// MARK: - Indicator
extension PlayerInfoView {

    func showLoading() {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
    }

    func hideLoading() {
        self.indicator.isHidden = true
        self.indicator.stopAnimating()
    }
}
