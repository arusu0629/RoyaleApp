//
//  SignOutTableViewCell.swift
//  Presentation
//
//  Created by nakandakari on 2020/10/02.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

protocol SignOutTableViewCellDelegate: AnyObject {
    func didTapSignOut()
}

final class SignOutTableViewCell: UITableViewCell {

    static let CellHeight: CGFloat = 70

    @IBOutlet private weak var nameLabel: UILabel! {
        willSet {
            newValue.text = AppConfig.playerTag
        }
    }

    weak var delegate: SignOutTableViewCellDelegate?
}

// MARK: - UserInteractino
extension SignOutTableViewCell {

    @IBAction private func didTapSingOut() {
        self.delegate?.didTapSignOut()
    }
}
