//
//  SettingsBuilder.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 02/10/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

enum SettingsBuilder {

    static func build() -> UIViewController {
        let view = SettingsViewController.instantiate()
        let presenter = SettingsPresenterImpl()
        let wireframe = SettingsWireframeImpl()

        view.presenter = presenter

        presenter.view = view
        presenter.wireframe = wireframe
        presenter.settingsSectionUseCase = SettingsSelectionUseCaseProvider.provide()
        presenter.realmBattleLogUseCase = RealmBattleLogsUseCaseProvider.provide()
        presenter.realmDeckModelUseCase = RealmDeckModelUseCaseProvider.provide()
        presenter.playerTagUseCase = PlayerTagUseCaseProvider.provide()
        presenter.lastSelectedDeckIndexUseCase = LastSelectedDeckIndexUseCaseProvider.provide()
        presenter.lastSelectedSortIndexUseCase = LastSelectedSortIndexUseCaseProvider.provide()
        presenter.lastSelectedFilterDateIndexUseCase = LastSelectedFilterDateIndexUseCaseProvider.provide()
        presenter.appLanguageUseCase = AppLanguageUseCaseProvider.provide()

        wireframe.viewController = view

        return view
    }
}
