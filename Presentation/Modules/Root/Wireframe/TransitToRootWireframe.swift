//
//  TransitToRootWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol TransitToRootWireframe: AnyObject {

    var viewController: UIViewController? { get }

    // func pushRoot()
    // func presentRoot()
}

extension TransitToRootWireframe {

    //func pushRoot() {
    //    let vc = RootBuilder.build()
    //    self.viewController?.navigationController?.pushViewController(vc, animated: true)
    //}

    //func presentRoot() {
    //    let vc = RootBuilder.build()
    //    self.viewController?.present(vc, animated: true, completion: nil)
    //}
}

//protocol RootWireframeDelegate: AnyObject {}
