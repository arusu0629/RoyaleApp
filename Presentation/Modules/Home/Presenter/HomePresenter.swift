//
//  HomePresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Analytics
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
        AnalyticsManager.sendEvent(HomeEvent.display)
        self.setup()
        self.view?.showFooterAdView()
    }

    func willEnterForground() {
        let filterDate = self.trophyDateFilterUseCase.list()[AppConfig.lastSelectedFilterDateIndex].filterDate
        self.requestBattleLog(with: filterDate)
    }

    func didSelectDateFilterButton(index: Int) {
        AppConfig.lastSelectedFilterDateIndex = index
        let trophyDateFilter = self.trophyDateFilterUseCase.list()[index]
        AnalyticsManager.sendEvent(HomeEvent.selectDateFilter(trophyDateFilter: trophyDateFilter))
        self.requestBattleLog(with: trophyDateFilter.filterDate)
    }
}

// MARK: - Setup
private extension HomePresenterImpl {

    func setup() {
        self.requestPlayerData()
        self.view?.setupTrophyDateFilter(trophyDateFilters: self.trophyDateFilterUseCase.list())
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
        self.view?.willFetchPlayerInfo()
        self.playerUseCase.get(playerTag: playerTag) { result in
            switch result {
            case .success(let playerModel):
                self.view?.didFetchPlayerInfo(playerModel: playerModel)
            case .failure(let error):
                self.view?.didFailedFetchPlayerInfo(error)
            }
        }
    }

    func requestBattleLogs(_ playerTag: String = AppConfig.playerTag) {
        if playerTag.isEmpty {
            return
        }
        self.view?.willFetchPlayerBattleLog()
        self.battleLogsUseCase.get(playerTag: playerTag) { result in
            switch result {
            case .success(let battleLogsModel):
                self.realmBattleLogsUseCase.save(objects: battleLogsModel.realmBattleLogs())
                let filterDate = self.trophyDateFilterUseCase.list()[AppConfig.lastSelectedFilterDateIndex].filterDate
                self.requestBattleLog(with: filterDate)
            case .failure(let error):
                self.view?.didFailedFetchPlayerInfo(error)
            }
        }
    }

    func requestUpComingChests(_ playerTag: String = AppConfig.playerTag) {
        if playerTag.isEmpty {
            return
        }
        self.view?.willFetchUpComingChests()
        self.chestsUseCase.get(playerTag: playerTag) { result in
            switch result {
            case .success(let upComingChestsModel):
                self.view?.didFetchUpComingChests(chestsModel: upComingChestsModel)
            case .failure(let error):
                self.view?.didFailedFetchPlayerBattleLog(error)
            }
        }
    }
}

// MARK: - Request Battle Log with date filter
extension HomePresenterImpl {

    // TODO: Refactoring
    func requestBattleLog(with filterDate: Date) {
        guard let battleLogsModels = self.realmBattleLogsUseCase.get() else {
            self.view?.didUpdatePlayerBattleLog(realmBattleLogs: [])
            return
        }
        var realmBattleLogs = [RealmBattleLogModel](battleLogsModels.sorted(byKeyPath: RealmBattleLogModel.sortedKey))
        realmBattleLogs = realmBattleLogs.filter { $0.battleDate >= filterDate }
        // Required two or more battle logs because the trophy graph cannot be showwn correctly
        if realmBattleLogs.count <= 1 {
            self.view?.didUpdatePlayerBattleLog(realmBattleLogs: [])
            return
        }
        self.view?.didUpdatePlayerBattleLog(realmBattleLogs: realmBattleLogs)
    }
}

// MARK: - SignIn
private extension HomePresenterImpl {

    func presentSignIn(dismissCompletion: (() -> Void)?) {
        self.wireframe.presentSignIn(dismissCompletion: dismissCompletion)
    }
}
