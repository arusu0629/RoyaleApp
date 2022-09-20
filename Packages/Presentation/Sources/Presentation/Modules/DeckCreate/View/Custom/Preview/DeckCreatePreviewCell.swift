//
//  DeckCreatePreviewCell.swift
//  Presentation
//
//  Created by nakandakari on 2020/08/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

final class DeckCreatePreviewCell: UICollectionViewCell {

    static let CellSize = CGSize(width: 40, height: 48)

    @IBOutlet private weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

// MARK: - Setup
extension DeckCreatePreviewCell {

    func setup(iconUrl: String, placeHolder: UIImage? = nil) {
        self.iconImageView.setImage(imageUrl: iconUrl, placeHolder: placeHolder)
    }
}
