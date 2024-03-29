//
//  RealmMigrateUseCase.swift
//  Domain
//
//  Created by nakandakari on 2020/12/18.
//

import DataStore
import Foundation

public enum RealmMigrateUseCaseProvider {
    public static func provide() -> RealmMigrateUseCase {
        return RealmMigrateuseCaseImpl(realmMigrateRepository: RealmMigrateRepositoryProvider.provide(configName: DataStoreConstant.battleLogConfigName, appGroupName: DataStoreConstant.appGroupName))
    }
}

public protocol RealmMigrateUseCase {
    func migrate(completion: (Result<Void, Error>) -> Void)
}

private struct RealmMigrateuseCaseImpl: RealmMigrateUseCase {

    private let realmMigrateRepository: RealmMigrateRepository

    init(realmMigrateRepository: RealmMigrateRepository) {
        self.realmMigrateRepository = realmMigrateRepository
    }

    func migrate(completion: (Result<Void, Error>) -> Void) {
        self.realmMigrateRepository.migrate(completion: completion)
    }
}
