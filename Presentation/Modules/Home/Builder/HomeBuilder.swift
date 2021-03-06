//
//  HomeBuilder.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

enum HomeBuilder {

    static func build() -> UIViewController {
        let view = HomeViewController.instantiate()
        let presenter = HomePresenterImpl()
        let wireframe = HomeWireframeImpl()

        view.presenter = presenter

        presenter.view = view
        presenter.wireframe = wireframe
        presenter.playerUseCase = PlayerUseCaseProvider.provide()
        presenter.battleLogsUseCase = BattleLogsUseCaseProvider.provide()
        presenter.chestsUseCase = UpComingChestsProvider.provide()
        presenter.realmBattleLogsUseCase = RealmBattleLogsUseCaseProvider.provide(battleLogConfigName: Constant.battleLogConfigName, appGroupName: Constant.appGroupName)
        presenter.trophyDateFilterUseCase = TrophyDateFilterUseCaseProvider.provide()

        wireframe.viewController = view

        return view
    }
}
