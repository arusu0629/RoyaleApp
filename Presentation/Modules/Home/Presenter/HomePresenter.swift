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
    var chestsUseCase: UpComingChestsUseCase!

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
        self.requestPlayerInfo()
    }
}

// MARK: - PlayerInfo
private extension HomePresenterImpl {

    private func requestPlayerInfo() {
        self.requestUpComingChests()
    }

    private func requestUpComingChests(_ playerTag: String = AppConfig.playerTag) {
        if playerTag.isEmpty {
            return
        }
        self.chestsUseCase.get(playerTag: playerTag) { result in
            switch result {
            case .success(let upComingChestsModel):
                self.view?.didFetchUpcomingChests(chestsModel: upComingChestsModel)
                AppConfig.playerTag = playerTag
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
