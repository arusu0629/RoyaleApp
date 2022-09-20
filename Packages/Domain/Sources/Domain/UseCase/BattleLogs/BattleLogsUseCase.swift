//
//  BattleLogsUseCase.swift
//  Domain
//
//  Created by nakandakari on 2020/06/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation

public enum BattleLogsUseCaseProvider {
    public static func provide() -> BattleLogsUseCase {
        return BattleLogsUseCaseImpl(translator: BattleLogsTranslatorProvider.provide(),
                                     repository: BattleLogsRepositoryProvider.provide())
    }
}

public protocol BattleLogsUseCase {
    typealias Completion = (Result<BattleLogsModel, Error>) -> Void

    func get(playerTag: String, completion: @escaping Completion)
}

private struct BattleLogsUseCaseImpl: BattleLogsUseCase {

    let translator: BattleLogsTranslator
    let repository: BattleLogsRepository

    func get(playerTag: String, completion: @escaping Completion) {
        self.repository.get(playerTag: playerTag) { result in
            switch result {
            case .success(let battleLogs):
                let battleLogsModel = self.translator.convert(from: battleLogs)
                completion(.success(battleLogsModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
