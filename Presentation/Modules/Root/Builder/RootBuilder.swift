//
//  RootBuilder.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

public enum RootBuilder {

    public static func build() -> UIViewController {
        let view = RootViewController.instantiate()
        let presenter = RootPresenterImpl()
        let wireframe = RootWireframeImpl()

        view.presenter = presenter

        presenter.view = view
        presenter.wireframe = wireframe

        wireframe.viewController = view

        return view
    }
}
