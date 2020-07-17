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
    func didFetchPlayerInfo(playerModel: PlayerModel)
    func didFetchPlayerBattleLog(realmBattleLogs: [RealmBattleLogModel])
    func didFetchUpcomingChests(chestsModel: UpComingChestsModel)
    func didUpdatePlayerBattleLog(realmBattleLogs: [RealmBattleLogModel])
    func willEnterForground()
    func setupTrophyDateFilter(trophyDateFilters: [TrophyDateFilter])
}

// MARK: - Properties
public final class HomeViewController: UIViewController {

    @IBOutlet private weak var playerInfoView: PlayerInfoView!
    @IBOutlet private weak var playerTrophyChartView: PlayerTrophyLineChartView! {
        willSet {
            newValue.dateFitlerDelegate = self
        }
    }
    @IBOutlet private weak var chestsListView: UIStackView!

    var presenter: HomePresenter!

    private var chestCells: [UpComingChestCell] = []
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

    func didFetchPlayerInfo(playerModel: PlayerModel) {
        self.playerInfoView.setup(playerModel: playerModel)
    }

    func didFetchPlayerBattleLog(realmBattleLogs: [RealmBattleLogModel]) {
        self.setupPlayerInfo(realmBattleLogs: realmBattleLogs)
    }

    func didFetchUpcomingChests(chestsModel: UpComingChestsModel) {
        self.removeAllChestCell()
        for chest in chestsModel.chests {
            let cell = self.createUpComingChestCell(chest: chest)
            self.chestsListView.addArrangedSubview(cell)
        }
    }

    func didUpdatePlayerBattleLog(realmBattleLogs: [RealmBattleLogModel]) {
        self.setupPlayerInfo(realmBattleLogs: realmBattleLogs)
    }

    public func willEnterForground() {
        self.presenter.willEnterForground()
    }

    func setupTrophyDateFilter(trophyDateFilters: [TrophyDateFilter]) {
        self.playerTrophyChartView.setupDateFilterTabView(texts: trophyDateFilters.map { $0.label }, initialIndex: AppConfig.lastSelectedFilterDateIndex)
    }
}

// MARK: - PlayerInfo
extension HomeViewController {

    private func setupPlayerInfo(realmBattleLogs: [RealmBattleLogModel]) {
        if realmBattleLogs.isEmpty {
            return
        }
        self.playerTrophyChartView.setupData(battleLogs: realmBattleLogs)
        let trophy = realmBattleLogs[realmBattleLogs.count - 1].afterTrophy
        self.playerInfoView.setupTrophy(trophy: trophy)
    }

    private func filterPlayerBattleLog(realmBattleLogs: [RealmBattleLogModel]) {
        if realmBattleLogs.isEmpty {
            return
        }
        self.playerTrophyChartView.setupData(battleLogs: realmBattleLogs)
    }
}

// MARK: - UpComingChestCell
extension HomeViewController {

    private func createUpComingChestCell(chest: UpComingChestsModel.UpComingChest) -> UpComingChestCell {
        let cell = UpComingChestCell()
        cell.widthAnchor.constraint(equalToConstant: UpComingChestCell.cellSize.width).isActive = true
        cell.heightAnchor.constraint(equalToConstant: UpComingChestCell.cellSize.height).isActive = true
        cell.setupChest(chest)
        self.chestCells.append(cell)
        return cell
    }

    private func removeAllChestCell() {
        for cell in self.chestCells {
            self.chestsListView.removeArrangedSubview(cell)
        }
        self.chestCells.removeAll()
    }
}

// MARK: - DateFilterTabViewDelegate
extension HomeViewController: DateFilterTabViewDelegate {

    func didTapFilterButton(index: Int) {
        self.presenter.didSelectDateFilterButton(index: index)
    }
}
