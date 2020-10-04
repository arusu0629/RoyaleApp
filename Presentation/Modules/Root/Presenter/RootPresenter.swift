//
//  RootPresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Foundation
import Domain

protocol RootPresenter: AnyObject {
    func viewWillAppear()

    func didSelectSettings()
}

final class RootPresenterImpl: RootPresenter {

    weak var view: RootView?
    var wireframe: RootWireframe!

    func viewWillAppear() {
        if AppConfig.playerTag.isEmpty {
            self.presentSignIn {
                self.view?.showAllTabs(TabUseCaseProvider.provide().list())
            }
            return
        }
        self.view?.showAllTabs(TabUseCaseProvider.provide().list())
    }
}

// MARK: - Signin
extension RootPresenterImpl {

    func presentSignIn(dismissCompletion: (() -> Void)?) {
        self.wireframe.presentSignIn(dismissCompletion: dismissCompletion)
    }
}

// MARK: - Settings
extension RootPresenterImpl {

    func didSelectSettings() {
        self.wireframe.pushSettings()
    }
}
