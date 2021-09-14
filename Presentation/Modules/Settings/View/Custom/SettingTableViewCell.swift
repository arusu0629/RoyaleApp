//
//  SettingTableViewCell.swift
//  Presentation
//
//  Created by nakandakari on 2020/11/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import UIKit

protocol SettingsTableViewCellDelegate: AnyObject {
    func didTapCell(setting: SettingsSection)
}

final class SettingTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var button: UIButton!

    private var settingSection: SettingsSection!

    weak var delegate: SettingsTableViewCellDelegate?
}

// MARK: - setSettingSection
extension SettingTableViewCell {

    func setSettingSection(_ settingSection: SettingsSection) {
        self.settingSection     = settingSection
        self.titleLabel.text    = settingSection.title
        self.subTitleLabel.text = settingSection.subTitle
        self.button.isEnabled   = settingSection.isButtonEnabled
    }
}

// MARK: - IBAction
extension SettingTableViewCell {

    @IBAction private func didTapCell() {
        guard let settingSection = self.settingSection else {
            return
        }
        self.delegate?.didTapCell(setting: settingSection)
    }
}

// MARK: - SettingsSection
private extension SettingsSection {

    var title: String {
        switch self {
        case .signOut    : return "SignOut"
        case .language   : return "Language"
        case .appVersion : return "App Version"
        }
    }

    var subTitle: String {
        switch self {
        case .signOut    : return PlayerTagUseCaseProvider.provide().get()
        case .language   : return AppLanguageUseCaseProvider.provide().get().description
        case .appVersion : return Bundle.appVersion
        }
    }

    var isButtonEnabled: Bool {
        switch self {
        case .signOut    : return true
        case .language   : return true
        case .appVersion : return false
        }
    }
}
