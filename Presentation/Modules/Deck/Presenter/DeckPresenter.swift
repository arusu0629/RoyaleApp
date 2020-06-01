//
//  DeckPresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Foundation

protocol DeckPresenter: AnyObject {}

final class DeckPresenterImpl: DeckPresenter {

    weak var view: DeckView?
    var wireframe: DeckWireframe!
}
