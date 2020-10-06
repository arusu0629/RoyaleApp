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
    func refreshHomeUI()
}

// MARK: - Properties
public final class RootViewController: SwipeableTabBarController {

    var presenter: RootPresenter!
}

// MARK: - Life cycle
extension RootViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationTitle()
        self.setupNavigationSettings()

        // FIXME: SwipeableTabBarController is called this before presenter is nil, So this code
        // Ideal: self.presenter.viewDidLoad -> self.view?.showAllTabs(TabUseCaseProvider.provide().list())
        self.showAllTabs(TabUseCaseProvider.provide().list())
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
}

// MARK: - RootView
extension RootViewController: RootView {

    func refreshHomeUI() {
        guard let viewControllers = self.viewControllers else {
            return
        }
        viewControllers.forEach {
            if let homeVC = $0 as? HomeViewController {
                homeVC.refreshUI()
            }
        }
    }
}

// MARK: - Setup
private extension RootViewController {

    func setupNavigationTitle() {
        self.navigationItem.titleView = {
            let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            let imageView = UIImageView(image: Asset.titleIcon.image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = titleView.bounds
            titleView.addSubview(imageView)
            return titleView
        }()
    }

    func setupNavigationSettings() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbols.settingIconImage, style: .plain, target: self, action: #selector(tappedSettings(_:)))
    }

    @objc func tappedSettings(_ sender: UIBarButtonItem) {
        self.presenter.didSelectSettings()
    }

    func showAllTabs(_ tabs: [Tab]) {
        let viewControllers: [UIViewController] = tabs.map { $0.viewController }
        self.setViewControllers(viewControllers, animated: false)
        self.selectedIndex = Tab.home.rawValue
    }
}

// MARK: - Tab
private extension Tab {

    var viewController: UIViewController {
        let vc: UIViewController = {
            switch self {
            case .home:
                return HomeBuilder.build()
            case .deck:
                return DeckBuilder.build()
            case .web:
                return WebBuilder.build()
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
        case .web:
            return "Web"
        }
    }

    private var image: UIImage? {
        let image: UIImage? = {
            switch self {
            case .home:
                return SFSymbols.homeIconImage
            case .deck:
                return SFSymbols.deckIconImage
            case .web:
                return SFSymbols.webIconImage
            }
        }()
        return image?.withRenderingMode(.alwaysOriginal)
    }

    private var selectedImage: UIImage? {
        let image: UIImage? = {
            switch self {
            case .home:
                return SFSymbols.homeFillIconImage
            case .deck:
                return SFSymbols.deckFillIconImage
            case .web:
                return SFSymbols.webFillIconImage
            }
        }()
        return image?.withRenderingMode(.alwaysOriginal)
    }

}
