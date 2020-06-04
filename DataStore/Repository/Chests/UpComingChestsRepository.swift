//
//  ChestsRepository.swift
//  DataStore
//
//  Created by nakandakari on 2020/06/04.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum UpComingChestsRepositoryProvider {

    public static func provide() -> UpComingChestsRepository {
        return ChestsRepositoryImpl(apiDataStore: CRAPIDataStoreProvider.provide())
    }
}

public protocol UpComingChestsRepository {
    typealias Completion = (Result<CRUpComingChestsResponse, Error>) -> Void

    func get(playerTag: String, completion: @escaping Completion)
}

private struct ChestsRepositoryImpl: UpComingChestsRepository {

    let apiDataStore: CRAPIDataStore

    func get(playerTag: String, completion: @escaping Completion) {
        self.apiDataStore.request(CRUpComingChestsAPIRequest(tag: playerTag), completion: completion)
    }
}
