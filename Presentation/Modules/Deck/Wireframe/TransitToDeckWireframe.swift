//
//  TransitToDeckWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol TransitToDeckWireframe: AnyObject {

    var viewController: UIViewController? { get }

    // func pushDeck()
    // func presentDeck()
}

extension TransitToDeckWireframe {

    // func pushDeck() {
    //    let vc = DeckBuilder.build()
    //    self.viewController?.navigationController?.pushViewController(vc, animated: true)
    // }

    // func presentDeck() {
    //    let vc = DeckBuilder.build()
    //    self.viewController?.present(vc, animated: true, completion: nil)
    // }
}

// protocol DeckWireframeDelegate: AnyObject {}
