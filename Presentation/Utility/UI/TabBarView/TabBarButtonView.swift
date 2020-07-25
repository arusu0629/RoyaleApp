//
//  TabBarButtonView.swift
//  Presentation
//
//  Created by nakandakari on 2020/07/16.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

protocol TabBarButtonViewDelegate: AnyObject {
    func didTapButton(index: Int)
}

final class TabBarButtonView: UIView {

    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var borderLine: UIView!

    private var index: Int = 0

    weak var delegate: TabBarButtonViewDelegate?

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

// MARK: - Setup
extension TabBarButtonView {

    func setup(text: String, index: Int) {
        self.button.setTitle(text, for: .normal)
        self.index = index
    }
}

// MARK: - Action
extension TabBarButtonView {

    @IBAction private func didTapTabButton() {
        self.delegate?.didTapButton(index: self.index)
    }

}

// MARK: - Interaction Enable
extension TabBarButtonView {

    func setEnableButton(isEnable: Bool) {
        self.button.isEnabled = isEnable
    }
}

// MARK: - Text, BorderLine Show/Hide
extension TabBarButtonView {

    func showBorderLine() {
        self.borderLine.isHidden = false
    }

    func hideBorderLine() {
        self.borderLine.isHidden = true
    }

    func showText() {
        self.button.titleLabel?.isHidden = false
    }

    func hideText() {
        self.button.titleLabel?.isHidden = true
    }
}
