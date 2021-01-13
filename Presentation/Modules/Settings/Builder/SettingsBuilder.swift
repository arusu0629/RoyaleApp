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
        presenter.realmBattleLogUseCase = RealmBattleLogsUseCaseProvider.provide(battleLogConfigName: Constant.battleLogConfigName, appGroupName: Constant.appGroupName)
        presenter.realmDeckModelUseCase = RealmDeckModelUseCaseProvider.provide(deckModelConfigName: Constant.deckModelConfigName, appGroupName: Constant.appGroupName)

        wireframe.viewController = view

        return view
    }
}
