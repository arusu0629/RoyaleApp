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
}

final class RootPresenterImpl: RootPresenter {

    weak var view: RootView?
    var wireframe: RootWireframe!

    func viewWillAppear() {
        self.view?.showAllTabs(TabUseCaseProvider.provide().list())
    }
}
