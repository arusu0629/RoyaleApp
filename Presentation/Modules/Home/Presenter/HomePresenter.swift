//
//  HomePresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Foundation

protocol HomePresenter: AnyObject {}

final class HomePresenterImpl: HomePresenter {

    weak var view: HomeView?
    var wireframe: HomeWireframe!
}
