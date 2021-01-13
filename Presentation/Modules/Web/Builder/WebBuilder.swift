//
//  WebBuilder.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 02/10/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

enum WebBuilder {

    static func build() -> UIViewController {
        let view = WebViewController.instantiate()
        let presenter = WebPresenterImpl()
        let wireframe = WebWireframeImpl()

        view.presenter = presenter

        presenter.view = view
        presenter.wireframe = wireframe
        presenter.webViewTabUseCase = WebViewTabUseCaseProvider.provide()
        presenter.lastSelectedWebViewTabIndexUseCase = LastSelectedWebViewTabIndexUseCaseProvider.provide()

        wireframe.viewController = view

        return view
    }
}
