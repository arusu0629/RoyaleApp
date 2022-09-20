//
//  TransitToSettingsWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 02/10/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol TransitToSettingsWireframe: AnyObject {

    var viewController: UIViewController? { get }
    func pushSettings()
}

extension TransitToSettingsWireframe {

    func pushSettings() {
        let vc = SettingsBuilder.build()
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
