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

    func showLogoutAlertView()
}

// MARK: - Properties
final class SettingsViewController: UIViewController {

    private let signOutAlertMessage = "Sure SignOut? \n\n All saved trophies and deck information will be deleted"

    @IBOutlet private weak var tableView: UITableView! {
        willSet {
            newValue.delaysContentTouches = false
            newValue.dataSource = self
            newValue.delegate = self
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
        self.settingsSections.forEach { self.tableView.register($0.nib, forCellReuseIdentifier: $0.className) }
        self.tableView.reloadData()
    }

    func showLogoutAlertView() {
        self.showAlert("", message: self.signOutAlertMessage, actions: [
            .init(title: "Cancel", style: .default, handler: nil),
            .init(title: "OK", style: .default, handler: { [weak self] _ in
                self?.presenter.didSelectLogout()
            })
            ]
        )
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
        switch settingSection {
        case .logout:
            let cell = tableView.dequeueReusableCell(withIdentifier: settingSection.className, for: indexPath) as! SignOutTableViewCell
            cell.delegate = self
            return cell
        }
    }
}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let settingsSection = self.settingsSections[indexPath.section]
        switch settingsSection {
        case .logout: return SignOutTableViewCell.CellHeight
        }
    }
}

// MARK: - SignOutTableViewCellDelegate
extension SettingsViewController: SignOutTableViewCellDelegate {

    func didTapSignOut() {
        self.presenter.didSelectLogoutCell()
    }
}

private extension SettingsSection {

    var nib: UINib {
        switch self {
        case .logout: return SignOutTableViewCell.nib
        }
    }

    var className: String {
        switch self {
        case .logout: return SignOutTableViewCell.className
        }
    }

}
