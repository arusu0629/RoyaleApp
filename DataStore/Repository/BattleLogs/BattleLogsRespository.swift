//
//  BattleLogsRespository.swift
//  DataStore
//
//  Created by nakandakari on 2020/06/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum BattleLogsRepositoryProvider {
    public static func provide() -> BattleLogsRepository {
        return BattleLogsRepositoryImpl(apiDataStore: CRAPIDataStoreProvider.provide())
    }
}

public protocol BattleLogsRepository {
    typealias Completion = (Result<[CRPlayerBattleLog], Error>) -> Void

    func get(playerTag: String, completion: @escaping Completion)
}

private struct BattleLogsRepositoryImpl: BattleLogsRepository {

    let apiDataStore: CRAPIDataStore

    func get(playerTag: String, completion: @escaping Completion) {
        self.apiDataStore.request(CRPlayerBattleLogsAPIRequest(tag: playerTag), completion: completion)
    }
}
