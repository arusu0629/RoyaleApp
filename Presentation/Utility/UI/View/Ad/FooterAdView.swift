//
//  FooterRectangleAdView.swift
//  Presentation
//
//  Created by nakandakari on 2020/10/01.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation
import UIKit

public final class FooterAdView: UIView {

    @IBOutlet private weak var indicator: UIActivityIndicatorView! {
        willSet {
            newValue.isHidden = true
        }
    }

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

extension FooterAdView {

    func setAdView(_ adView: UIView) {
        self.subviews.forEach { $0.removeFromSuperview() }
        self.addSubview(adView)
    }
}

// MARK: - Loading
extension FooterAdView {

    func showLoading() {
        self.indicator.isHidden = false
        self.indicator.startAnimating()
    }

    func hideLoading() {
        self.indicator.isHidden = true
        self.indicator.stopAnimating()
    }
}
