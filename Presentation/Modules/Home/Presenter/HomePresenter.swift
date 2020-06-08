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
        self.requestUpComingChests()
    }

    private func requestUpComingChests() {
        // TODO: 消す (UserDefaultから取ってくる？)
        let playerTag = "%23R89920JY"
        self.chestsUseCase.get(playerTag: playerTag) { result in
            switch result {
            case .success(let upComingChestsModel):
                self.view?.didFetchUpcomingChests(chestsModel: upComingChestsModel)
            case .failure(let error):
                print("[requestUpComingChests Error] error = \(error)")
            }
        }
    }

}
