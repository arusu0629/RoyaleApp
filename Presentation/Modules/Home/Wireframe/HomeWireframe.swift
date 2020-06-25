//
//  HomeWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol HomeWireframe: TransitToSignInWireframe {}

final class HomeWireframeImpl: HomeWireframe {

    weak var viewController: UIViewController?
}
