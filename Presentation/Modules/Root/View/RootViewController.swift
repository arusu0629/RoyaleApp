//
//  RootViewController.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol RootView: AnyObject {}

// MARK: - Properties
final class RootViewController: UIViewController {

    var presenter: RootPresenter!
}

// MARK: - Life cycle
extension RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - RootView
extension RootViewController: RootView {
}
