//
//  UpComingChestCell.swift
//  Presentation
//
//  Created by nakandakari on 2020/06/04.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import UIKit

final class UpComingChestCell: UIView {

    static let cellSize = CGSize(width: 80, height: 80)

    @IBOutlet private weak var chestImage: UIImageView!
    @IBOutlet private weak var indexLabel: UILabel!

    private var chest: UpComingChestsModel.UpComingChest?

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

extension UpComingChestCell {

    func setupChest(_ chest: UpComingChestsModel.UpComingChest) {
        self.chest = chest
        self.chestImage.image = chest.image
        self.indexLabel.text = chest.label
        self.setIndexLabelCornerRadius()
    }

    private func setIndexLabelCornerRadius() {
        let radius = self.indexLabel.frame.width / 3.0
        self.indexLabel.layer.cornerRadius = radius
    }
}

// MARK: - Refresh text
extension UpComingChestCell {

    func refreshText() {
        self.indexLabel.text = self.chest?.label
    }
}

private extension UpComingChestsModel.UpComingChest {

    var image: UIImage? {
        switch self.type {
        case .silver:
            return Asset.chestSilver.image
        case .golden:
            return Asset.chestGold.image
        case .giant:
            return Asset.chestGiant.image
        case .magical:
            return Asset.chestMagical.image
        case .epic:
            return Asset.chestEpic.image
        case .legendary:
            return Asset.chestLegendary.image
        case .megaLightning:
            return Asset.chestMegalightning.image
        case .goldCrate:
            return Asset.chestGoldcrate.image
        case .plentifulGoldCrate:
            return Asset.chestPlentifulgoldcrate.image
        case .overflowingGoldCrate:
            return Asset.chestOverflowinggoldcrate.image
        case .royalWild:
            return Asset.chestRoyalwild.image
        case .none:
            return nil
        }
    }

    var label: String {
        if self.index < 0 {
            return ""
        }
        if self.index == 0 {
            return "next_upcoming_chest_title_key".localized
        }
        return "+\(self.index)"
    }
}
