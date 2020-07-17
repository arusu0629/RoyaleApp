//
//  HomePresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import Foundation

protocol HomePresenter: AnyObject {
    func viewDidLoad()
    func willEnterForground()
    func didSelectDateFilterButton(index: Int)
}

final class HomePresenterImpl: HomePresenter {

    weak var view: HomeView?
    var wireframe: HomeWireframe!
    var playerUseCase: PlayerUseCase!
    var battleLogsUseCase: BattleLogsUseCase!
    var chestsUseCase: UpComingChestsUseCase!
    var realmBattleLogsUseCase: RealmBattleLogsUseCase!
    var trophyDateFilterUseCase: TrophyDateFilterUseCase!

    func viewDidLoad() {
        if AppConfig.playerTag.isEmpty {
            self.presentSignIn(dismissCompletion: self.setup)
            return
        }
        self.setup()
        self.view?.setupTrophyDateFilter(trophyDateFilters: self.trophyDateFilterUseCase.list())
    }

    func willEnterForground() {
        let filterDate = self.trophyDateFilterUseCase.list()[AppConfig.lastSelectedFilterDateIndex].filterDate
        self.requestBattleLog(with: filterDate)
    }

    func didSelectDateFilterButton(index: Int) {
        AppConfig.lastSelectedFilterDateIndex = index
        let filterDate = self.trophyDateFilterUseCase.list()[index].filterDate
        self.requestBattleLog(with: filterDate)
    }
}

// MARK: - Setup
private extension HomePresenterImpl {

    func setup() {
        self.requestPlayerData()
    }
}

// MARK: - Request Player Data
private extension HomePresenterImpl {

    func requestPlayerData() {
        self.requestPlayerInfo()
        self.requestBattleLogs()
        self.requestUpComingChests()
    }

    func requestPlayerInfo(_ playerTag: String = AppConfig.playerTag) {
        if playerTag.isEmpty {
            return
        }
        self.playerUseCase.get(playerTag: playerTag) { result in
            switch result {
            case .success(let playerModel):
                self.view?.didFetchPlayerInfo(playerModel: playerModel)
            case .failure(let error):
                self.view?.showErrorAlert(error)
            }
        }
    }

    func requestBattleLogs(_ playerTag: String = AppConfig.playerTag) {
        if playerTag.isEmpty {
            return
        }
        self.battleLogsUseCase.get(playerTag: playerTag) { result in
            switch result {
            case .success(let battleLogsModel):
                self.realmBattleLogsUseCase.save(objects: battleLogsModel.realmBattleLogs())
                let filterDate = self.trophyDateFilterUseCase.list()[AppConfig.lastSelectedFilterDateIndex].filterDate
                self.requestBattleLog(with: filterDate)
            case .failure(let error):
                self.view?.showErrorAlert(error)
            }
        }
    }

    func requestUpComingChests(_ playerTag: String = AppConfig.playerTag) {
        if playerTag.isEmpty {
            return
        }
        self.chestsUseCase.get(playerTag: playerTag) { result in
            switch result {
            case .success(let upComingChestsModel):
                self.view?.didFetchUpcomingChests(chestsModel: upComingChestsModel)
            case .failure(let error):
                self.view?.showErrorAlert(error)
            }
        }
    }

    func updateBattleLogs() {
        guard let battleLogModels = self.realmBattleLogsUseCase.get() else {
            return
        }
        let realmBattleLogs = [RealmBattleLogModel](battleLogModels.sorted(byKeyPath: RealmBattleLogModel.sortedKey))
        self.view?.didUpdatePlayerBattleLog(realmBattleLogs: realmBattleLogs)
    }
}

// MARK: - Request Battle Log with date filter
extension HomePresenterImpl {

    func requestBattleLog(with filterDate: Date) {
        guard let battleLogsModels = self.realmBattleLogsUseCase.get() else {
            self.view?.didUpdatePlayerBattleLog(realmBattleLogs: [])
            return
        }
        var realmBattleLogs = [RealmBattleLogModel](battleLogsModels.sorted(byKeyPath: RealmBattleLogModel.sortedKey))
        realmBattleLogs = realmBattleLogs.filter { $0.battleDate >= filterDate }
        self.view?.didUpdatePlayerBattleLog(realmBattleLogs: realmBattleLogs)
    }
}

// MARK: - SignIn
private extension HomePresenterImpl {

    func presentSignIn(dismissCompletion: (() -> Void)?) {
        self.wireframe.presentSignIn(dismissCompletion: dismissCompletion)
    }
}
