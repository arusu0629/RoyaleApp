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
}

final class HomePresenterImpl: HomePresenter {

    weak var view: HomeView?
    var wireframe: HomeWireframe!
    var playerUseCase: PlayerUseCase!
    var battleLogsUseCase: BattleLogsUseCase!
    var chestsUseCase: UpComingChestsUseCase!
    var realmBattleLogsUseCase: RealmBattleLogsUseCase!

    func viewDidLoad() {
        if AppConfig.playerTag.isEmpty {
            self.presentSignIn(dismissCompletion: self.setup)
            return
        }
        self.setup()
    }

    func willEnterForground() {
        self.updatePlayerData()
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

    private func requestPlayerData() {
        self.requestPlayerInfo()
        self.requestBattleLogs()
        self.requestUpComingChests()
    }

    private func updatePlayerData() {
        self.updateBattleLogs()
    }

    private func requestPlayerInfo(_ playerTag: String = AppConfig.playerTag) {
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

    private func requestBattleLogs(_ playerTag: String = AppConfig.playerTag) {
        if playerTag.isEmpty {
            return
        }
        self.battleLogsUseCase.get(playerTag: playerTag) { result in
            switch result {
            case .success(let battleLogsModel):
                if let latestBattleLog = self.realmBattleLogsUseCase.getLatest() {
                    let realmBattleLogs = battleLogsModel.realmBattleLogs()
                    let filteredRealmBattleLogs = realmBattleLogs.filter { $0.battleDate > latestBattleLog.battleDate }
                }
                self.realmBattleLogsUseCase.save(objects: battleLogsModel.realmBattleLogs())
                guard let battleLogModels = self.realmBattleLogsUseCase.get() else {
                    self.view?.didFetchPlayerBattleLog(realmBattleLogs: [])
                    return
                }
                let realmBattleLogs = [RealmBattleLogModel](battleLogModels.sorted(byKeyPath: RealmBattleLogModel.sortedKey))
                self.view?.didFetchPlayerBattleLog(realmBattleLogs: realmBattleLogs)
            case .failure(let error):
                self.view?.showErrorAlert(error)
            }
        }
    }

    private func requestUpComingChests(_ playerTag: String = AppConfig.playerTag) {
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

    private func updateBattleLogs() {
        guard let battleLogModels = self.realmBattleLogsUseCase.get() else {
            return
        }
        let realmBattleLogs = [RealmBattleLogModel](battleLogModels.sorted(byKeyPath: RealmBattleLogModel.sortedKey))
        self.view?.didUpdatePlayerBattleLog(realmBattleLogs: realmBattleLogs)
    }
}

// MARK: - SignIn
private extension HomePresenterImpl {

    func presentSignIn(dismissCompletion: (() -> Void)?) {
        self.wireframe.presentSignIn(dismissCompletion: dismissCompletion)
    }
}
