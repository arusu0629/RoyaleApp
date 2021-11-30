//
//  TransitToWebWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 02/10/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol TransitToWebWireframe: AnyObject {

    var viewController: UIViewController? { get }

    // func pushWeb()
    // func presentWeb()
}

extension TransitToWebWireframe {

    // func pushWeb() {
    //    let vc = WebBuilder.build()
    //    self.viewController?.navigationController?.pushViewController(vc, animated: true)
    // }

    // func presentWeb() {
    //    let vc = WebBuilder.build()
    //    self.viewController?.present(vc, animated: true, completion: nil)
    // }
}

// protocol WebWireframeDelegate: AnyObject {}
