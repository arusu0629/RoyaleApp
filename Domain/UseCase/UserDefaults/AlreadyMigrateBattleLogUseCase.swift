//
//  AlreadyMigrateBattleLogUseCase.swift
//  Domain
//
//  Created by nakandakari on 2021/01/14.
//

import DataStore
import Foundation

public enum AlreadyMigrateBattleLogUseCaseProvider {
    public static func provide() -> AlreadyMigrateBattleLogUseCase {
        return AlreadyMigrateBattleLogUseCaseImpl(repository: UserDefaultsRepositoryProvider.provide())
    }
}

public protocol AlreadyMigrateBattleLogUseCase {
    func get() -> Bool
    func set(flag: Bool)
}

private struct AlreadyMigrateBattleLogUseCaseImpl: AlreadyMigrateBattleLogUseCase {

    private var repository: UserDefaultsRepository

    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }

    func get() -> Bool {
        guard let alreadyMigrateBattleLog: Bool = self.repository.get(type: .alreadyMigrateBattleLog) else {
            return false
        }
        return alreadyMigrateBattleLog
    }

    func set(flag: Bool) {
        self.repository.set(value: flag, type: .alreadyMigrateBattleLog)
    }
}
