//
//  PlayerRepository.swift
//  DataStore
//
//  Created by nakandakari on 2020/05/27.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum PlayerRepositoryProvider {
    
    public static func provide() -> PlayerRepository {
        return PlayerRepositoryImpl(apiDataStore: CRAPIDataStoreProvider.provide())
    }
}

public protocol PlayerRepository {
    typealias Complection = (Result<CRPlayerResponse, Error>) -> Void
    
    func get(playerTag: String, completion: @escaping Complection)
}

private struct PlayerRepositoryImpl: PlayerRepository {
    
    let apiDataStore: CRAPIDataStore
    
    func get(playerTag: String, completion: @escaping Complection) {
        self.apiDataStore.request(CRPlayerAPIRequest(tag: playerTag), completion: completion)
    }
}
