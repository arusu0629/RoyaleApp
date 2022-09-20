//
//  SignInWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 24/06/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol SignInWireframe: AnyObject {
    func dismiss(completion: (() -> Void)?)
}

final class SignInWireframeImpl: SignInWireframe {

    weak var viewController: UIViewController?

    func dismiss(completion: (() -> Void)?) {
        self.viewController?.dismiss(animated: true, completion: completion)
    }
}
