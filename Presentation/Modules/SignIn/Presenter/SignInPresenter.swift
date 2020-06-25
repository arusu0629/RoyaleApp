//
//  SignInPresenter.swift
//  RoyaleApp
//
//  Created by t-nakandakari on 24/06/2020.
//  Copyright © 2020 arusu0629. All rights reserved.
//

import Domain
import Foundation

protocol SignInPresenter: AnyObject {
    func textFieldShouldReturn(_ text: String)
}

final class SignInPresenterImpl: SignInPresenter {

    weak var view: SignInView?
    var wireframe: SignInWireframe!
    var playerUseCase: PlayerUseCase!

    var dismissCompletion: (() -> Void)?

    init(dismissCompletion: (() -> Void)?) {
        self.dismissCompletion = dismissCompletion
    }
}

// MARK: - SignInPresenter
extension SignInPresenterImpl {

    func textFieldShouldReturn(_ text: String) {
        self.requestPlayerInfo(playerTag: text)
    }
}

// MARK: - RequestPlayerInfo
extension SignInPresenterImpl {

    func requestPlayerInfo(playerTag: String) {
        let convertPlayerTag = AppConfig.convertPlayerTag(playerTag)
        self.playerUseCase.get(playerTag: convertPlayerTag) { result in
            switch result {
            case .success:
                AppConfig.playerTag = convertPlayerTag
                self.wireframe.dismiss(completion: self.dismissCompletion)
            case .failure(let error):
                self.view?.showErrorAlert(error)
            }
        }
    }
}
