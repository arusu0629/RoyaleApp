//
//  SignInBuilder.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 24/06/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

public enum SignInBuilder {

    public static func build(dismissCompletion: (() -> Void)?) -> UIViewController {
        let view = SignInViewController.instantiate()
        let presenter = SignInPresenterImpl(dismissCompletion: dismissCompletion)
        let wireframe = SignInWireframeImpl()

        view.presenter = presenter

        presenter.view = view
        presenter.wireframe = wireframe
        presenter.playerUseCase = PlayerUseCaseProvider.provide()
        presenter.playerTagUseCase = PlayerTagUseCaseProvider.provide()

        wireframe.viewController = view

        return view
    }
}
