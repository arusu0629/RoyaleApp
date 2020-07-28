//
//  DeckPreviewCell.swift
//  Presentation
//
//  Created by nakandakari on 2020/07/27.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

final class DeckPreviewCell: UICollectionViewCell {

    static let CellSize = CGSize(width: 80, height: 96)

    let iconUrlString = "https://api-assets.clashroyale.com/cards/300/Fmltc4j3Ve9vO_xhHHPEO3PRP3SmU2oKp2zkZQHRZT4.png"

    @IBOutlet private weak var cardIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
