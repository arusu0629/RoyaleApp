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

    @IBOutlet private weak var nameAndTagLabel: UILabel!
    @IBOutlet private weak var clanLabel: UILabel!
    @IBOutlet private weak var trophyLabel: UILabel!

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
        self.clanLabel.text = playerModel.clanName
    }

    func setupTrophy(trophy: Int) {
        self.trophyLabel.text = String(trophy)
    }
}
