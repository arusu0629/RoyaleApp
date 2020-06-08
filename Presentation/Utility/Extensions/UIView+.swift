//
//  UIView+.swift
//  Presentation
//
//  Created by nakandakari on 2020/06/04.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

// MARK: - nib
extension UIView {

    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }

    var nib: UINib {
        return type(of: self).nib
    }
}

// MARK: - Load
extension UIView {

    func loadXib(_ nibName: String? = nil) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName ?? self.className, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView ?? { fatalError("Can not load xib!") }()
        self.addSubview(view)
        self.backgroundColor = UIColor.clear

        // adjust size
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: bindings))

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                           options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                           metrics: nil,
                                                           views: bindings))
    }
}
