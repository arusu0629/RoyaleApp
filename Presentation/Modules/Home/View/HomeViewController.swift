//
//  HomeViewController.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol HomeView: AnyObject {}

// MARK: - Properties
final class HomeViewController: UIViewController {

    var presenter: HomePresenter!
}

// MARK: - Life cycle
extension HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - HomeView
extension HomeViewController: HomeView {
}
