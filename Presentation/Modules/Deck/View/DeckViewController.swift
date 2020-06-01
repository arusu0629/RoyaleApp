//
//  DeckViewController.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import UIKit

protocol DeckView: AnyObject {}

// MARK: - Properties
final class DeckViewController: UIViewController {

    var presenter: DeckPresenter!
}

// MARK: - Life cycle
extension DeckViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - DeckView
extension DeckViewController: DeckView {
}
