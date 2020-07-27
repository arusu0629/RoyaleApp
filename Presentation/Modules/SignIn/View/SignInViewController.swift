//
//  SignInViewController.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 24/06/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol SignInView: ShowErrorAlertView {}

// MARK: - Properties
final class SignInViewController: UIViewController {

    var presenter: SignInPresenter!

    @IBOutlet private weak var inputPlayerTagTextField: UITextField! {
        willSet {
            newValue.delegate = self
        }
    }

    @IBOutlet private var stackView: UIStackView!
    @IBOutlet private var stackViewCenterYConstraint: NSLayoutConstraint!

    deinit {
        self.unRegisterKeyboardManagerDelegate()
    }

    private func registerKeyboardManagerDelegate() {
        KeyboardManager.shared.delegate = self
    }

    private func unRegisterKeyboardManagerDelegate() {
        KeyboardManager.shared.delegate = nil
    }
}

// MARK: - Life cycle
extension SignInViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}

// MARK: - Setup
private extension SignInViewController {

    func setup() {
        self.registerKeyboardManagerDelegate()
        self.setupTextFieldPlaceholder()
    }

    func setupTextFieldPlaceholder() {
        let buttonText = "Input player tag"
        // Shifting the placeholder letter up from the baseline to the bottom of the g
        let attributes = [
            NSAttributedString.Key.baselineOffset: NSNumber(value: 1.0)
        ]
        let attrText = NSAttributedString(string: buttonText, attributes: attributes)
        self.inputPlayerTagTextField.attributedPlaceholder = attrText
    }
}

// MARK: - SignInView
extension SignInViewController: SignInView {
}

// MARK: - UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.inputPlayerTagTextField.resignFirstResponder()
        self.presenter.textFieldShouldReturn(textField.text ?? "")
        return true
    }
}

// MARK: - TouchesBegan
extension SignInViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.closeInputPlayerTagTextField()
    }
}

// MARK: - InputPlayerTagTextField
extension SignInViewController {

    private func closeInputPlayerTagTextField() {
        self.inputPlayerTagTextField.resignFirstResponder()
    }
}

// MARK: - KeyboardManagerDelegate
extension SignInViewController: KeyboardManagerDelegate {

    func willShow(keyboardInfo: KeyboardInfo) {
        let stackViewBottomY = self.stackView.frame.origin.y + self.stackView.frame.size.height
        let spacingBetweenViewAndKeyboard: CGFloat = 10
        let diffY = stackViewBottomY + spacingBetweenViewAndKeyboard - keyboardInfo.rect.origin.y

        // キーボードに隠れていない
        if diffY <= 0 {
            return
        }

        // キーボードの高さに合わせて TextField を上げる
        self.stackViewCenterYConstraint.constant = -diffY
        UIView.animate(withDuration: keyboardInfo.duration) {
            self.view.layoutIfNeeded()
        }
    }

    func willHide(keyboardInfo: KeyboardInfo) {
        self.stackViewCenterYConstraint.constant = 0
        UIView.animate(withDuration: keyboardInfo.duration) {
            self.view.layoutIfNeeded()
        }
    }
}
