//
//  UpComingChestCell.swift
//  Presentation
//
//  Created by nakandakari on 2020/06/04.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit
import Domain

final class UpComingChestCell: UIView {

    static let cellSize = CGSize(width: 80, height: 80)

    @IBOutlet private weak var chestImage: UIImageView!
    @IBOutlet private weak var indexLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initilize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initilize()
    }

    private func initilize() {
        self.loadXib()
    }
}

extension UpComingChestCell {

    func setupChest(_ chest: UpComingChestsModel.UpComingChest) {
        self.chestImage.image = chest.image
        self.indexLabel.text = chest.label
        self.setIndexLabelCornerRadius()
    }

    private func setIndexLabelCornerRadius() {
        let radius = self.indexLabel.frame.width / 3.0
        self.indexLabel.layer.cornerRadius = radius
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
        case .none:
            return nil
        }
    }

    var label: String {
        if self.index < 0 {
            return ""
        }
        if self.index == 0 {
            return "Next"
        }
        return "+\(self.index)"
    }
}
