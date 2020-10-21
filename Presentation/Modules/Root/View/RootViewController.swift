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

protocol RootView: ShowErrorAlertView {
    func refreshHomeUI()

    func showMovie()
    func cancelMovie()
}

// MARK: - Properties
public final class RootViewController: SwipeableTabBarController {

    private let confirmMovieAlertTitle:   String = "Update your player information?"
    private let confirmMovieAlertMessage: String = "show movie to update"

    private let loadingViewTitle: String = "Ready for movie reward ad"

    var presenter: RootPresenter!
}

// MARK: - Life cycle
extension RootViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
}

// MARK: - RootView
extension RootViewController: RootView {

    func refreshHomeUI() {
        guard let homeVC = self.getHomeViewController() else {
            return
        }
        homeVC.refreshUI()
    }

    func showMovie() {
        self.showLoading()
        MovieRewardManager.shared.setupMovieRewardAd(dataSource: self, delegate: self)
    }

    func cancelMovie() {
        self.hideLoading()
        MovieRewardManager.shared.requestCancelMovieReward()
    }
}

// MARK: - HomeViewController
private extension RootViewController {

    func getHomeViewController() -> HomeViewController? {
        guard let viewControllers = self.viewControllers else {
            return nil
        }
        let homeVC = viewControllers.first(where: { $0 is HomeViewController }) as? HomeViewController
        return homeVC
    }
}

// MARK: - Setup
private extension RootViewController {

    func setup() {
        self.setupNavigationTitle()
        self.setupNavigationSettings()
        self.setupNavigationRefresh()
        self.setupNotification()

        // FIXME: SwipeableTabBarController is called this before presenter is nil, So this code
        // Ideal: self.presenter.viewDidLoad -> self.view?.showAllTabs(TabUseCaseProvider.provide().list())
        self.showAllTabs(TabUseCaseProvider.provide().list())
    }

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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbols.navigationItemSettingIconImage, style: .plain, target: self, action: #selector(tappedSettings(_:)))
    }

    func setupNavigationRefresh() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: SFSymbols.navigationItemRefreshIconImage, style: .plain, target: self, action: #selector(tappedRefresh(_:)))
    }

    func showAllTabs(_ tabs: [Tab]) {
        let viewControllers: [UIViewController] = tabs.map { $0.viewController }
        self.setViewControllers(viewControllers, animated: false)
        self.selectedIndex = Tab.home.rawValue
    }

    func setupNotification() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(showSetting(_:)), name: Notification.Name.Setting.show, object: nil)
        center.addObserver(self, selector: #selector(hideSetting(_:)), name: Notification.Name.Setting.hide, object: nil)
        center.addObserver(self, selector: #selector(showRefresh(_:)), name: Notification.Name.Refresh.show, object: nil)
        center.addObserver(self, selector: #selector(hideRefresh(_:)), name: Notification.Name.Refresh.hide, object: nil)
    }
}

// MARK: - objc
private extension RootViewController {

    @objc func tappedSettings(_ sender: UIBarButtonItem) {
        self.presenter.didSelectSettings()
    }

    @objc func tappedRefresh(_ sender: UIBarButtonItem) {
        self.showAlert(self.confirmMovieAlertTitle, message: self.confirmMovieAlertMessage, actions: [
            .init(title: "Cancel", style: .default, handler: nil),
            .init(title: "OK", style: .default, handler: { _ in
                self.presenter.didSelectRefresh()
            })
        ])
    }

    @objc func showSetting(_ sender: NSNotification) {
        self.setupNavigationSettings()
    }

    @objc func hideSetting(_ sender: NSNotification) {
        self.navigationItem.rightBarButtonItem = nil
    }

    @objc func showRefresh(_ sender: NSNotification) {
        self.setupNavigationRefresh()
    }

    @objc func hideRefresh(_ sender: NSNotification) {
        self.navigationItem.leftBarButtonItem = nil
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

// MARK: - Loading
private extension RootViewController {

    func showLoading() {
        let loadingView = LoadingManager.shared.createCancelableLoadingView(title: self.loadingViewTitle)
        loadingView.delegate = self
        loadingView.show()
        self.view.addSubview(loadingView)
        self.view.bringSubviewToFront(loadingView)
        self.navigationController?.navigationBar.isUserInteractionEnabled = false
        self.isSwipeEnabled = false
    }

    func hideLoading() {
        self.navigationController?.navigationBar.isUserInteractionEnabled = true
        self.isSwipeEnabled = true
        self.view.subviews.forEach {
            if let loadingView = $0 as? CancelableLoadingView {
                loadingView.hide()
                loadingView.removeFromSuperview()
                return
            }
        }
    }
}

// MARK: - CancelableLoadingViewDelegate
extension RootViewController: CancelableLoadingViewDelegate {

    func didTapCancel() {
        self.presenter.didSelectCancelRefresh()
    }
}

// MARK: - MovieReward
extension RootViewController: MovieRewardManagerDelegate, MovieRewardManagerDataSource {

    public func currentViewController() -> UIViewController {
        return self
    }

    public func didPresentMovieReward() {
        self.hideLoading()
    }

    public func didSuccessMovieReward() {
        self.presenter.didSuccessMovieReward()
    }

    public func didCancelMovieReward() {
        self.presenter.didCancelMovieReward()
    }

    public func didFailedMovieReward(error: Error) {
        self.hideLoading()
        self.presenter.didFailedToPresentMovie(error: error)
    }
}
