//
//  SignInDescriptionCell.swift
//  Presentation
//
//  Created by nakandakari on 2020/10/09.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

final class SignInDescriptionCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupImage(_ image: UIImage) {
        self.imageView.image = image
    }

}
