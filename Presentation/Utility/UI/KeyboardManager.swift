//
//  KeyboardManager.swift
//  Presentation
//
//  Created by nakandakari on 2020/06/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

struct KeyboardInfo {
    var duration: Double
    var rect: CGRect
}

protocol KeyboardManagerDelegate: AnyObject {
    func willShow(keyboardInfo: KeyboardInfo)
    func willHide(keyboardInfo: KeyboardInfo)
}

final class KeyboardManager: NSObject {

    static let shared = KeyboardManager()

    private override init() {
        super.init()
        self.setup()
    }

    weak var delegate: KeyboardManagerDelegate?
}

// MARK: - Setup
private extension KeyboardManager {

    func setup() {
        NotificationCenter.default.addObserver(
            self,
            selector:#selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    // キーボードを表示の処理
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else {
            return

        }
        guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        guard let rect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.delegate?.willShow(keyboardInfo: KeyboardInfo(duration: duration, rect: rect))
    }

    // キーボードが閉じたときの処理
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Any] else {
            return

        }
        guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        guard let rect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.delegate?.willHide(keyboardInfo: KeyboardInfo(duration: duration, rect: rect))
    }
}
