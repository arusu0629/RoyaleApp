//
//  PlayerUseCase.swift
//  Domain
//
//  Created by nakandakari on 2020/06/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation

public enum PlayerUseCaseProvider {

    public static func provide() -> PlayerUseCase {
        return PlayerUseCaseImpl(translator: PlayerTranslatorProvider.provide(),
                                 repository: PlayerRepositoryProvider.provide())
    }
}

public protocol PlayerUseCase {
    typealias Completion = (Result<PlayerModel, Error>) -> Void

    func get(playerTag: String, completion: @escaping Completion)
}

private struct PlayerUseCaseImpl: PlayerUseCase {

    let translator: PlayerTranslator
    let repository: PlayerRepository

    func get(playerTag: String, completion: @escaping (Result<PlayerModel, Error>) -> Void) {
        self.repository.get(playerTag: playerTag) { result in
            switch result {
            case .success(let response):
                let playerModel = self.translator.convert(from: response)
                if playerModel.isEmptyTag() {
                    completion(.failure(PlayerModelError.invalid))
                    return
                }
                completion(.success(playerModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
