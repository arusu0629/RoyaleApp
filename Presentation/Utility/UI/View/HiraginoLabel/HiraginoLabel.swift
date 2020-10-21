//
//  HiraginoLabel.swift
//  Presentation
//
//  Created by nakandakari on 2020/10/21.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

final class HiraginoLabel: UILabel {

    override var intrinsicContentSize: CGSize {
        let origin = super.intrinsicContentSize
        return self.calcSize(origin: origin)
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let origin = super.sizeThatFits(size)
        return self.calcSize(origin: origin)
    }

    private func calcSize(origin: CGSize) -> CGSize {
        let font = self.font
        return CGSize(width: ceil(origin.width), height: ceil(origin.height + abs(font?.descender ?? 0)))
    }
}
