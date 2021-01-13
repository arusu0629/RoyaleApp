//
//  DeckBuilder.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

enum DeckBuilder {

    static func build() -> UIViewController {
        let view = DeckViewController.instantiate()
        let presenter = DeckPresenterImpl()
        let wireframe = DeckWireframeImpl()

        view.presenter = presenter

        presenter.view = view
        presenter.wireframe = wireframe
        presenter.playerUserCase = PlayerUseCaseProvider.provide()
        presenter.realmDeckModelUseCase = RealmDeckModelUseCaseProvider.provide()
        presenter.playerTagUseCase = PlayerTagUseCaseProvider.provide()
        presenter.lastSelectedDeckIndexUseCase = LastSelectedDeckIndexUseCaseProvider.provide()

        wireframe.viewController = view

        return view
    }
}
