//
//  RootPresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import Foundation

protocol RootPresenter: AnyObject {
    func viewWillAppear()

    func didSelectSettings()
    func didSelectRefresh()

    func didSelectCancelRefresh()
}

final class RootPresenterImpl: RootPresenter {

    weak var view: RootView?
    var wireframe: RootWireframe!

    func viewWillAppear() {
        if !AppConfig.playerTag.isEmpty {
            return
        }
        self.presentSignIn(dismissCompletion: {
            self.view?.refreshHomeUI()
        })
    }

    func didSelectSettings() {
        self.wireframe.pushSettings()
    }

    func didSelectRefresh() {
        self.view?.showMovie()
    }

    func didSelectCancelRefresh() {
        self.view?.cancelMovie()
    }
}

// MARK: - Signin
extension RootPresenterImpl {

    func presentSignIn(dismissCompletion: (() -> Void)?) {
        self.wireframe.presentSignIn(dismissCompletion: dismissCompletion)
    }
}
