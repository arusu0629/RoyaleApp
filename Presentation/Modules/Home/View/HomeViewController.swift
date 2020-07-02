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
}

// MARK: - Properties
final class HomeViewController: UIViewController {

    @IBOutlet private weak var playerInfoView: PlayerInfoView!
    @IBOutlet private weak var playerTrophyChartView: PlayerTrophyLineChartView!
    @IBOutlet private weak var chestsListView: UIStackView!

    var presenter: HomePresenter!

    private var chestCells: [UpComingChestCell] = []
}

// MARK: - Life cycle
extension HomeViewController {

    override func viewDidLoad() {
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
        if realmBattleLogs.isEmpty {
            return
        }
        self.playerTrophyChartView.setupData(battleLogs: realmBattleLogs)
    }

    func didFetchUpcomingChests(chestsModel: UpComingChestsModel) {
        self.removeAllChestCell()
        for chest in chestsModel.chests {
            let cell = self.createUpComingChestCell(chest: chest)
            self.chestsListView.addArrangedSubview(cell)
        }
    }
}

// MARK: UpComingChestCell
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
