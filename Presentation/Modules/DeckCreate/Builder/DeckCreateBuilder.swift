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

    static func build(deckIndex: Int, selectedCardList: [CardModel], dismissCompletion: (() -> Void)? = nil) -> UIViewController {
        let view = DeckCreateViewController.instantiate()
        let presenter = DeckCreatePresenterImpl(deckIndex: deckIndex, selectedCardList: selectedCardList, dismissCompletion: dismissCompletion)
        let wireframe = DeckCreateWireframeImpl()

        view.presenter = presenter

        presenter.view = view
        presenter.wireframe = wireframe
        presenter.playerUseCase = PlayerUseCaseProvider.provide()
        presenter.realmDeckModelUseCase = RealmDeckModelUseCaseProvider.provide()

        wireframe.viewController = view

        return view
    }
}
