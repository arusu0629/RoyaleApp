//
//  WebWireframe.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 02/10/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol WebWireframe: AnyObject {}

final class WebWireframeImpl: WebWireframe {

    weak var viewController: UIViewController?
}
