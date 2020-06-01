//
//  HomeBuilder.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

enum HomeBuilder {

    static func build() -> UIViewController {
        let view = HomeViewController.instantiate()
        let presenter = HomePresenterImpl()
        let wireframe = HomeWireframeImpl()

        view.presenter = presenter

        presenter.view = view
        presenter.wireframe = wireframe

        wireframe.viewController = view

        return view
    }
}
