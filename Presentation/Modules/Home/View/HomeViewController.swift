//
//  HomeViewController.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import UIKit

protocol HomeView: ShowErrorAlertView {
    func willFetchPlayerInfo()
    func willFetchUpComingChests()
    func willFetchPlayerBattleLog()
    func didFetchPlayerInfo(playerModel: PlayerModel)
    func didFetchUpComingChests(chestsModel: UpComingChestsModel)
    func didUpdatePlayerBattleLog(realmBattleLogs: [RealmBattleLogModel])
    func didFailedFetchPlayerInfo(_ error: Error)
    func didFailedFetchUpComingChests(_ error: Error)
    func didFailedFetchPlayerBattleLog(_ error: Error)
    func setupTrophyDateFilter(trophyDateFilters: [TrophyDateFilter])
    func willEnterForground()

    // Ad
    func showFooterAdView()
    func hideFooterAdView()
}

// MARK: - Properties
public final class HomeViewController: UIViewController {

    @IBOutlet private weak var playerInfoView: PlayerInfoView!
    @IBOutlet private weak var playerTrophyChartView: PlayerTrophyLineChartView! {
        willSet {
            newValue.dateFitlerDelegate = self
        }
    }
    @IBOutlet private weak var upcomingChestListView: UpComingChestListView!

    // Ad
    @IBOutlet private weak var footerAdView: FooterAdView!

    var presenter: HomePresenter!

    private var isFinishViewDidLoad = false
}

// MARK: - Life cycle
extension HomeViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        self.isFinishViewDidLoad = true
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showNavigationItem()
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideNavigationItem()
    }
}

// MARK: - HomeView
extension HomeViewController: HomeView {

    func willFetchPlayerInfo() {
        self.playerInfoView.showLoading()
    }

    func willFetchUpComingChests() {
        self.upcomingChestListView.showLoading()
    }

    func willFetchPlayerBattleLog() {
        self.playerTrophyChartView.showLoading()
    }

    func didFetchPlayerInfo(playerModel: PlayerModel) {
        self.playerInfoView.setup(playerModel: playerModel)
        self.playerInfoView.setupTrophy(trophy: playerModel.trophies)
        self.playerInfoView.hideLoading()
    }

    func didFetchUpComingChests(chestsModel: UpComingChestsModel) {
        self.setupUpComingChest(chestsModel: chestsModel)
        self.upcomingChestListView.hideLoading()
    }

    func didUpdatePlayerBattleLog(realmBattleLogs: [RealmBattleLogModel]) {
        self.setupPlayerInfo(realmBattleLogs: realmBattleLogs)
        self.playerTrophyChartView.hideLoading()
    }

    func didFailedFetchPlayerInfo(_ error: Error) {
        self.playerInfoView.hideLoading()
        self.showErrorAlert(error)
    }

    func didFailedFetchUpComingChests(_ error: Error) {
        self.upcomingChestListView.hideLoading()
        self.showErrorAlert(error)
    }

    func didFailedFetchPlayerBattleLog(_ error: Error) {
        self.playerTrophyChartView.hideLoading()
        self.showErrorAlert(error)
    }

    func setupTrophyDateFilter(trophyDateFilters: [TrophyDateFilter]) {
        self.playerTrophyChartView.setupDateFilterTabView(texts: trophyDateFilters.map { $0.label }, initialIndex: AppConfig.lastSelectedFilterDateIndex)
    }

    public func willEnterForground() {
        self.presenter.willEnterForground()
    }

    func showFooterAdView() {
        self.footerAdView.showLoading()
        AdManager.shared.setupAd(dataSource: self, delegate: self, targetView: self.footerAdView)
    }

    func hideFooterAdView() {
        self.footerAdView.isHidden = true
    }
}

// MARK: - Show, Hide Navigation Item
private extension HomeViewController {

    func showNavigationItem() {
        self.showSettingNavigationItem()
        self.showRefreshNavigationItem()
    }

    func hideNavigationItem() {
        self.hideSettingNavigationItem()
        self.hideRefreshNavigationItem()
    }

    func showSettingNavigationItem() {
        NotificationCenter.default.post(name: Notification.Name.Setting.show, object: nil)
    }

    func hideSettingNavigationItem() {
        NotificationCenter.default.post(name: Notification.Name.Setting.hide, object: nil)
    }

    func showRefreshNavigationItem() {
        NotificationCenter.default.post(name: Notification.Name.Refresh.show, object: nil)
    }

    func hideRefreshNavigationItem() {
        NotificationCenter.default.post(name: Notification.Name.Refresh.hide, object: nil)
    }
}

// MARK: - Refresh UI
extension HomeViewController {

    func refreshUI() {
        if self.isFinishViewDidLoad {
            self.presenter.refreshUI()
        }
    }
}

// MARK: - PlayerInfo
extension HomeViewController {

    private func setupPlayerInfo(realmBattleLogs: [RealmBattleLogModel]) {
        if realmBattleLogs.isEmpty {
            self.playerTrophyChartView.setupNoData()
            return
        }
        self.playerTrophyChartView.setupData(battleLogs: realmBattleLogs)
    }
}

// MARK: - UpComingChestCell
extension HomeViewController {

    private func setupUpComingChest(chestsModel: UpComingChestsModel) {
        self.upcomingChestListView.setup(chestsModel: chestsModel)
    }
}

// MARK: - DateFilterTabViewDelegate
extension HomeViewController: DateFilterTabViewDelegate {

    func didTapFilterButton(index: Int) {
        self.presenter.didSelectDateFilterButton(index: index)
    }
}

// MARK: - AdManagerDataSource
extension HomeViewController: AdManagerDataSource {

    public func currentViewController() -> UIViewController {
        return self
    }
}

// MARK: - AdManagerDelegate
extension HomeViewController: AdManagerDelegate {

    public func didReceiveAd() {
        self.footerAdView.hideLoading()
        self.footerAdView.isHidden = false
    }

    public func didFailedAd() {
        self.hideFooterAdView()
        self.footerAdView.hideLoading()
    }
}
