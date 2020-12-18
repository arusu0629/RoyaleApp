//
//  RealmMigrateRepository.swift
//  DataStore
//
//  Created by nakandakari on 2020/12/18.
//

import Foundation

public enum RealmMigrateRepositoryProvider {
    public static func provide(configName: String) -> RealmMigrateRepository {
        return RealmMigrateRepositoryImpl(realmDataStore: RealmDataStoreProvider.provide(configName: configName))
    }
}

public protocol RealmMigrateRepository {
    func migrate(completion: (Result<Void, Error>) -> Void)
}

private struct RealmMigrateRepositoryImpl: RealmMigrateRepository {

    private let realmDataStore: RealmDataStore

    init(realmDataStore: RealmDataStore) {
        self.realmDataStore = realmDataStore
    }

    func migrate(completion: (Result<Void, Error>) -> Void) {
        self.realmDataStore.migrate(completion: completion)
    }
}
