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

    private let signOutAlertMessage = "Sure SignOut? \n\n All saved trophies and deck information will be deleted"

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
    }

    func setupNavigationTitle() {
        self.title = "Settings"
    }
}

// MARK: - SettingsView
extension SettingsViewController: SettingsView {

    func reloadData(settingsSections: [SettingsSection]) {
        self.settingsSections = settingsSections
        self.tableView.reloadData()
    }

    func showSignOutAlertView() {
        self.showAlert("", message: self.signOutAlertMessage, actions: [
            .init(title: "Cancel", style: .default, handler: nil),
            .init(title: "OK", style: .default, handler: { [weak self] _ in
                self?.presenter.didSelectSignOut()
            })
        ])
    }

    func showLanguageActionSheet(languages: [AppLanguage]) {
        let sheet = UIAlertController(title: "Select Language", message: "", preferredStyle: .actionSheet)
        languages.forEach { language in
            sheet.addAction(.init(title: language.description, style: .default, handler: { [weak self] _ in
                self?.presenter.didSelectLanguage(language)
            }))
        }
        sheet.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
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

// MARK: - SettingsSection
private extension SettingsSection {

    var cellHeight: CGFloat {
        switch self {
        case .signOut, .language, .appVersion:
            return 70.0
        }
    }
}
