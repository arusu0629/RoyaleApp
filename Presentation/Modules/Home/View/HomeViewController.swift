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

    var presenter: HomePresenter!
}

// MARK: - Life cycle
extension HomeViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
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
}

// MARK: - PlayerInfo
extension HomeViewController {

    private func setupPlayerInfo(realmBattleLogs: [RealmBattleLogModel]) {
        if realmBattleLogs.isEmpty {
            self.playerTrophyChartView.setupNoData()
            return
        }
        self.playerTrophyChartView.setupData(battleLogs: realmBattleLogs)
        let trophy = realmBattleLogs[realmBattleLogs.count - 1].afterTrophy
        self.playerInfoView.setupTrophy(trophy: trophy)
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
