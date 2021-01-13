//
//  SettingsPresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 02/10/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import Foundation

protocol SettingsPresenter: AnyObject {
    func viewDidLoad()

    func didSelectCell(settingsSection: SettingsSection)
    func didSelectSignOut()
    func didSelectBack()
}

final class SettingsPresenterImpl: SettingsPresenter {

    weak var view: SettingsView?
    var wireframe: SettingsWireframe!
    var realmBattleLogUseCase: RealmBattleLogsUseCase!
    var realmDeckModelUseCase: RealmDeckModelUseCase!
    var settingsSectionUseCase: SettingsSelectionUseCase!
    var playerTagUseCase: PlayerTagUseCase!
    var lastSelectedDeckIndexUseCase: LastSelectedDeckIndexUseCase!
    var lastSelectedSortIndexUseCase: LastSelectedSortIndexUseCase!
    var lastSelectedFilterDateIndexUseCase: LastSelectedFilterDateIndexUseCase!

    func viewDidLoad() {
        self.view?.reloadData(settingsSections: self.settingsSectionUseCase.all())
    }

    func didSelectCell(settingsSection: SettingsSection) {
        switch settingsSection {
        case .SignOut:
            self.view?.showSignOutAlertView()
        case .AppVersion:
            break
        }
    }

    func didSelectSignOutCell() {
        self.view?.showSignOutAlertView()
    }

    func didSelectSignOut() {
        // Delete battle info, deck info with usecase
        self.realmBattleLogUseCase.deleteAll { result in
            switch result {
            case .success:
                self.realmDeckModelUseCase.deleteAll { result in
                    switch result {
                    case .success:
                        self.playerTagUseCase.set(playerTag: "")
                        self.resetAppConfigIndex()
                        self.wireframe.popViewController()
                    case .failure(let error):
                        self.view?.showErrorAlert(error)
                    }
                }
            case .failure(let error):
                self.view?.showErrorAlert(error)
            }
        }
    }

    func didSelectBack() {
        self.wireframe.popViewController()
    }

    private func resetAppConfigIndex() {
        self.lastSelectedDeckIndexUseCase.set(index: 0)
        self.lastSelectedSortIndexUseCase.set(index: 0)
        self.lastSelectedFilterDateIndexUseCase.set(index: 0)
    }
}
