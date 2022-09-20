//
//  TransitToSigninWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 24/06/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol TransitToSignInWireframe: AnyObject {

    var viewController: UIViewController? { get }

    func presentSignIn(dismissCompletion: (() -> Void)?)
}

extension TransitToSignInWireframe {

    func presentSignIn(dismissCompletion: (() -> Void)?) {
        let vc = SignInBuilder.build(dismissCompletion: dismissCompletion)
        self.viewController?.present(vc, animated: true, completion: nil)
    }
}
