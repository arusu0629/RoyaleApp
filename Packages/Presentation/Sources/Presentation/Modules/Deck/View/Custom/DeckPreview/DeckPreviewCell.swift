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

    @IBOutlet private weak var cardIconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: - Setup
extension DeckPreviewCell {

    func setData(iconUrl: String, placeHolder: UIImage? = nil) {
        self.cardIconImageView.setImage(imageUrl: iconUrl, placeHolder: placeHolder)
    }
}
