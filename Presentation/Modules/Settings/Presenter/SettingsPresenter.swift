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
    func didSelectLanguage(_ language: AppLanguage)
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
    var appLanguageUseCase: AppLanguageUseCase!

    func viewDidLoad() {
        self.view?.reloadData(settingsSections: self.settingsSectionUseCase.all())
    }

    func didSelectCell(settingsSection: SettingsSection) {
        switch settingsSection {
        case .signOut:
            self.view?.showSignOutAlertView()
        case .language:
            self.view?.showLanguageActionSheet(languages: self.appLanguageUseCase.all())
        case .appVersion:
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

    func didSelectLanguage(_ language: AppLanguage) {
        self.appLanguageUseCase.set(language: language)
        self.view?.reloadData(settingsSections: self.settingsSectionUseCase.all())
        // TODO: Notification とかで各画面に言語が変わった事を通知する
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
