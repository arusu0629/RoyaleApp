//
//  UIImageView+.swift
//  Presentation
//
//  Created by nakandakari on 2020/08/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImage(imageUrl: String, placeHolder: UIImage? = nil) {
        let url = URL(string: imageUrl)
        self.kf.setImage(with: url, placeholder: placeHolder)
    }
}
