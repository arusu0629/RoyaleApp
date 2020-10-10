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

    func didSelectSignOutCell()
    func didSelectSignOut()
    func didSelectBack()
}

final class SettingsPresenterImpl: SettingsPresenter {

    weak var view: SettingsView?
    var wireframe: SettingsWireframe!
    var realmBattleLogUseCase: RealmBattleLogsUseCase!
    var realmDeckModelUseCase: RealmDeckModelUseCase!

    var settingsSectionUseCase: SettingsSelectionUseCase!

    func viewDidLoad() {
        self.view?.reloadData(settingsSections: self.settingsSectionUseCase.all())
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
                        AppConfig.playerTag = ""
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
        AppConfig.lastSelectedDeckIndex = 0
        AppConfig.lastSelectedSortIndex = 0
        AppConfig.lastSelectedFilterDateIndex = 0
        AppConfig.lastSelectedWebViewTabIndex = 0
    }
}
