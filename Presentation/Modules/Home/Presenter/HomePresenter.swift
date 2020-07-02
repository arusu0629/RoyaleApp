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
}

final class HomePresenterImpl: HomePresenter {

    weak var view: HomeView?
    var wireframe: HomeWireframe!
    var playerUseCase: PlayerUseCase!
    var battleLogsUseCase: BattleLogsUseCase!
    var chestsUseCase: UpComingChestsUseCase!
    var realmUseCase: RealmUseCase!

    func viewDidLoad() {
        if AppConfig.playerTag.isEmpty {
            self.presentSignIn(dismissCompletion: self.setup)
            return
        }
        self.setup()
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
                self.realmUseCase.save(objects: battleLogsModel.realmBattleLogs())
                guard let battleLogModels = self.realmUseCase.get(with: RealmBattleLogModel.self) else {
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
}

// MARK: - SignIn
private extension HomePresenterImpl {

    func presentSignIn(dismissCompletion: (() -> Void)?) {
        self.wireframe.presentSignIn(dismissCompletion: dismissCompletion)
    }
}
