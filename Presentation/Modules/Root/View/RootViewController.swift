//
//  RootViewController.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import SwipeableTabBarController
import UIKit

import DataStore

protocol RootView: AnyObject {
    func showAllTabs(_ tabs: [Tab])
}

// MARK: - Properties
final class RootViewController: SwipeableTabBarController {

    var presenter: RootPresenter!
}

// MARK: - Life cycle
extension RootViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()

        UpComingChestsRepositoryProvider.provide().get(playerTag: "%23R89920JY") { result in
            //        ChestsRepositoryProvider.provide().get(playerTag: "8L9L9GL") { result in
            //        PlayerRepositoryProvider.provide().get(playerTag: "%23R89920JY") { result in
            switch result {
            case .success(let response):
                print("$$$ response = \(response)")
            case.failure(let error):
                print("$$$ error = \(error)")
            }
        }
    }
}

// MARK: - RootView
extension RootViewController: RootView {

    func showAllTabs(_ tabs: [Tab]) {
        let viewControllers: [UIViewController] = tabs.map { $0.viewController }
        self.setViewControllers(viewControllers, animated: false)
    }
}

private extension Tab {

    var viewController: UIViewController {
        let vc: UIViewController = {
            switch self {
            case .home:
                return HomeBuilder.build()
            case .deck:
                return DeckBuilder.build()
            }
        }()
        vc.tabBarItem = self.tabBarItem
        return vc
    }

    private var tabBarItem: UITabBarItem {
        let item = UITabBarItem(title: self.title, image: self.image, selectedImage: self.selectedImage)
        item.tag = self.rawValue
        return item
    }

    private var title: String {
        switch self {
        case .home:
            return "Home"
        case .deck:
            return "Deck"
        }
    }

    private var image: UIImage? {
        let image: UIImage? = {
            switch self {
            case .home:
                return Asset.homeIconNonSelect.image
            case .deck:
                return Asset.deckIconNonSelect.image
            }
        }()
        return image?.withRenderingMode(.alwaysOriginal)
    }

    private var selectedImage: UIImage? {
        let image: UIImage? = {
            switch self {
            case .home:
                return Asset.homeIconSelected.image
            case .deck:
                return Asset.deckIconSelected.image
            }
        }()
        return image?.withRenderingMode(.alwaysOriginal)
    }

}
