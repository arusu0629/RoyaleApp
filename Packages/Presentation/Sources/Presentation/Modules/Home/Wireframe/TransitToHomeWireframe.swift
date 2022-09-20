//
//  TransitToHomeWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol TransitToHomeWireframe: AnyObject {

    var viewController: UIViewController? { get }

    // func pushHome()
    // func presentHome()
}

extension TransitToHomeWireframe {

    // func pushHome() {
    //    let vc = HomeBuilder.build()
    //    self.viewController?.navigationController?.pushViewController(vc, animated: true)
    // }

    // func presentHome() {
    //    let vc = HomeBuilder.build()
    //    self.viewController?.present(vc, animated: true, completion: nil)
    // }
}

// protocol HomeWireframeDelegate: AnyObject {}
