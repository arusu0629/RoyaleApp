//
//  RootPresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 29/05/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Analytics
import Domain
import Foundation

protocol RootPresenter: AnyObject {
    func viewWillAppear()

    func didSelectSettings()
    func didSelectRefresh()

    func didSelectCancelRefresh()

    // Movie Reward
    func didSuccessMovieReward()
    func didCancelMovieReward()
    func didFailedToPresentMovie(error: Error)
}

final class RootPresenterImpl: RootPresenter {

    weak var view: RootView?
    var wireframe: RootWireframe!

    var playerTagUseCase: PlayerTagUseCase!

    func viewWillAppear() {
        if !self.playerTagUseCase.get().isEmpty {
            return
        }
        self.presentSignIn(dismissCompletion: {
            self.view?.refreshHomeUI()
        })
    }

    func didSelectSettings() {
        self.wireframe.pushSettings()
    }

    func didSelectRefresh() {
        AnalyticsManager.sendEvent(HomeEvent.selectPlayMovie)
        self.view?.showMovie()
    }

    func didSelectCancelRefresh() {
        AnalyticsManager.sendEvent(HomeEvent.selectCancelMovie)
        self.view?.cancelMovie()
    }

    func didSuccessMovieReward() {
        AnalyticsManager.sendEvent(HomeEvent.successMovieReward)
        self.view?.refreshHomeUI()
    }

    func didCancelMovieReward() {
        AnalyticsManager.sendEvent(HomeEvent.cancelMovieReward)
    }

    func didFailedToPresentMovie(error: Error) {
        AnalyticsManager.sendEvent(HomeEvent.failedPlayMovie)
        self.view?.showErrorAlert(error)
    }
}

// MARK: - Signin
extension RootPresenterImpl {

    func presentSignIn(dismissCompletion: (() -> Void)?) {
        self.wireframe.presentSignIn(dismissCompletion: dismissCompletion)
    }
}
