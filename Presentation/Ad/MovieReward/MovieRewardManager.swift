//
//  MovieRewardManager.swift
//  Presentation
//
//  Created by nakandakari on 2020/10/11.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation
import UIKit

public protocol MovieRewardManagerDataSource: AnyObject {
    func currentViewController() -> UIViewController
}

public protocol MovieRewardManagerDelegate: AnyObject {
    func didPresentMovieReward()
    func didSuccessMovieReward()
    func didCancelMovieReward()
    func didFailedMovieReward(error: Error)
}

extension MovieRewardManagerDelegate {
    func didPresentMovieReward() {}
}

protocol MovieRewardManagerProtocol: AnyObject {
    var movieRewardDelegate: MovieRewardReceiverDelegate? { get set }

    func requestCancelMovieReward()
}

protocol MovieRewardReceiverDelegate: AnyObject {
    func didPresentMovieReward()
    func didSuccessMovieReward()
    func didCancelMovieReward()
    func didFailedMovieReward(error: Error)
}

public final class MovieRewardManager {

    static let shared = MovieRewardManager()

    private init() {}

    public static func setup() {
        AdMobManager.setup()
    }

    weak var delegate: MovieRewardManagerDelegate?
    weak var dataSource: MovieRewardManagerDataSource?

    private var currentMovieRewardManager: MovieRewardManagerProtocol?
    private var adMobManager: AdMobManager?
}

extension MovieRewardManager {

    func setupMovieRewardAd(dataSource: MovieRewardManagerDataSource, delegate: MovieRewardManagerDelegate) {
        guard let adNetwork = MovieRewardNetwork.all().first else {
            // TODO: Clean 処理
            return
        }
        self.dataSource = dataSource
        self.delegate = delegate
        self.setupMovieRewardView(adNetwork: adNetwork)
    }

    private func setupMovieRewardView(adNetwork: MovieRewardNetwork) {
        guard let vc = self.dataSource?.currentViewController() else {
            return
        }
        switch adNetwork {
        case .admob(let id):
            self.adMobManager = AdMobManager()
            self.adMobManager?.movieRewardDelegate = self
            self.adMobManager?.setupMovieReward(vc: vc, id: id)
            self.currentMovieRewardManager = self.adMobManager
        }
    }

    func requestCancelMovieReward() {
        self.currentMovieRewardManager?.requestCancelMovieReward()
    }
}

extension MovieRewardManager: MovieRewardReceiverDelegate {

    func didPresentMovieReward() {
        self.delegate?.didPresentMovieReward()
    }

    func didSuccessMovieReward() {
        self.delegate?.didSuccessMovieReward()
    }

    func didCancelMovieReward() {
        self.delegate?.didCancelMovieReward()
    }

    func didFailedMovieReward(error: Error) {
        self.delegate?.didFailedMovieReward(error: error)
    }
}
