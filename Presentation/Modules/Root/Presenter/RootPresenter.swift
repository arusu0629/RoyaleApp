//
//  RootPresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Foundation

protocol RootPresenter: AnyObject {}

final class RootPresenterImpl: RootPresenter {

    weak var view: RootView?
    var wireframe: RootWireframe!
}
