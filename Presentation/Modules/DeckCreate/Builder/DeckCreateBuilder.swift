//
//  DeckCreateBuilder.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 30/08/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

enum DeckCreateBuilder {

    static func build(deckIndex: Int, selectedCardList: [CardModel]) -> UIViewController {
        let view = DeckCreateViewController.instantiate()
        let presenter = DeckCreatePresenterImpl(deckIndex: deckIndex, selectedCardList: selectedCardList)
        let wireframe = DeckCreateWireframeImpl()

        view.presenter = presenter

        presenter.view = view
        presenter.wireframe = wireframe
        presenter.playerUseCase = PlayerUseCaseProvider.provide()
        presenter.realmDeckModelUseCase = RealmDeckModelUseCaseProvider.provide(deckModelConfigName: Constant.deckModelConfigName, appGroupName: Constant.appGroupName)
        presenter.playerTagUseCase = PlayerTagUseCaseProvider.provide()
        presenter.lastSelectedSortIndexUseCase = LastSelectedSortIndexUseCaseProvider.provide()

        wireframe.viewController = view

        return view
    }
}
