//
//  DeckCreateWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 30/08/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

protocol DeckCreateWireframe: AnyObject {
    func dismiss(completion: (() -> Void)?)
}

final class DeckCreateWireframeImpl: DeckCreateWireframe {

    weak var viewController: UIViewController?

    func dismiss(completion: (() -> Void)?) {
        // passed create deck info previous vc
        self.viewController?.dismiss(animated: true, completion: completion)
    }
}
