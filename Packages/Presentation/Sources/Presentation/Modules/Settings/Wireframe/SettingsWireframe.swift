//
//  SettingsWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 02/10/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol SettingsWireframe: AnyObject {
    func popViewController()
}

final class SettingsWireframeImpl: SettingsWireframe {

    weak var viewController: UIViewController?

    func popViewController() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }

}
