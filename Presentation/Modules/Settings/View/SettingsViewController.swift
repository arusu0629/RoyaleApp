//
//  SettingsViewController.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 02/10/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

protocol SettingsView: ShowErrorAlertView {
    func reloadData(settingsSections: [SettingsSection])

    func showSignOutAlertView()
    func showLanguageActionSheet(languages: [AppLanguage])
}

// MARK: - Properties
final class SettingsViewController: UIViewController {

    private let buttonCancelTitleKey           = "button_cancel_title_key"
    private let buttonOkTitleKey               = "button_ok_title_key"
    private let tabBarTitleKey                 = "settings_tab_title_key"
    private let signOutAlertMessageKey         = "settings_sign_out_alert_message_key"
    private let appLanguageActionSheetTitleKey = "settings_app_language_action_sheet_title_key"

    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.delaysContentTouches = false
            newValue.dataSource = self
            newValue.delegate = self
            newValue.register(SettingTableViewCell.nib, forCellReuseIdentifier: SettingTableViewCell.className)
        }
    }

    var presenter: SettingsPresenter!

    private var settingsSections: [SettingsSection] = []
}

// MARK: - Life cycle
extension SettingsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.setup()
    }
}

// MARK: - Setup
private extension SettingsViewController {

    func setup() {
        self.setupNavigationTitle()
        self.setupNotification()
    }

    func setupNavigationTitle() {
        self.title = self.tabBarTitleKey.localized
    }

    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeAppLanguage(_:)), name: Notification.Name.AppLanguage.didChange, object: nil)
    }
}

// MARK: - SettingsView
extension SettingsViewController: SettingsView {

    func reloadData(settingsSections: [SettingsSection]) {
        self.settingsSections = settingsSections
        self.tableView.reloadData()
    }

    func showSignOutAlertView() {
        let cancelTitle = self.buttonCancelTitleKey.localized
        let okTitle     = self.buttonOkTitleKey.localized
        self.showAlert("", message: self.signOutAlertMessageKey.localized, actions: [
            .init(title: cancelTitle, style: .default, handler: nil),
            .init(title: okTitle, style: .default, handler: { [weak self] _ in
                self?.presenter.didSelectSignOut()
            })
        ])
    }

    func showLanguageActionSheet(languages: [AppLanguage]) {
        let sheet = UIAlertController(title: self.appLanguageActionSheetTitleKey.localized, message: "", preferredStyle: .actionSheet)
        languages.forEach { language in
            sheet.addAction(.init(title: language.description, style: .default, handler: { [weak self] _ in
                self?.presenter.didSelectLanguage(language)
            }))
        }
        sheet.addAction(.init(title: self.buttonCancelTitleKey.localized, style: .cancel, handler: nil))
        self.present(sheet, animated: true, completion: nil)
    }
}

// MARK: - UserInteraction
extension SettingsViewController {

    @IBAction private func didTapBackButton() {
        self.presenter.didSelectBack()
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.settingsSections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingSection = self.settingsSections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.className, for: indexPath) as! SettingTableViewCell
        cell.setSettingSection(settingSection)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .clear
        return header
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let settingsSection = self.settingsSections[indexPath.section]
        return settingsSection.cellHeight
    }
}

// MARK: - SignOutTableViewCellDelegate
extension SettingsViewController: SettingsTableViewCellDelegate {

    func didTapCell(setting: SettingsSection) {
        self.presenter.didSelectCell(settingsSection: setting)
    }
}

// MARK: - objc
extension SettingsViewController {

    @objc func didChangeAppLanguage(_ sender: NSNotification) {
        self.refreshText()
    }
}

// MARK: - Refresh text
private extension SettingsViewController {

    func refreshText() {
        self.title = self.tabBarTitleKey.localized
        self.tableView.reloadData()
    }
}

// MARK: - SettingsSection
private extension SettingsSection {

    var cellHeight: CGFloat {
        switch self {
        case .signOut, .language, .appVersion:
            return 70.0
        }
    }
}
