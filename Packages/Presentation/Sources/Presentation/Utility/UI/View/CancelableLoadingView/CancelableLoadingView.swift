//
//  CancelableLoadingView.swift
//  Presentation
//
//  Created by nakandakari on 2020/10/18.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

protocol CancelableLoadingViewDelegate: AnyObject {
    func didTapCancel()
}

final class CancelableLoadingView: UIView {

    private let cancelButtonTitleKey = "button_cancel_title_key"

    @IBOutlet private weak var indicator: UIActivityIndicatorView! {
        willSet {
            newValue.stopAnimating()
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var cancelButton: UIButton! {
        willSet {
            newValue.setTitle(self.cancelButtonTitleKey.localized, for: .normal)
        }
    }

    weak var delegate: CancelableLoadingViewDelegate?

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
extension CancelableLoadingView {

    func setTitle(_ title: String) {
        self.titleLabel.text = title
        self.hide()
    }
}

// MARK: - Show/Hide
extension CancelableLoadingView {

    func show() {
        self.indicator.startAnimating()
        self.isHidden = false
    }

    func hide() {
        self.indicator.stopAnimating()
        self.isHidden = true
    }
}

// MARK: - Action
extension CancelableLoadingView {

    @IBAction private func didTapButton() {
        self.delegate?.didTapCancel()
    }
}
