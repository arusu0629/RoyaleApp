//
//  LastRequestPlayerBattleLogsTimeUseaCase.swift
//  Domain
//
//  Created by nakandakari on 2021/01/14.
//

import DataStore
import Foundation

public enum LastRequestPlayerBattleLogsTimeUseCaseProvider {
    public static func provide() -> LastRequestPlayerBattleLogsTimeUseCase {
        return LastRequestPlayerBattleLogsTimeUseCaseImpl(repository: UserDefaultsRepositoryProvider.provide())
    }
}

public protocol LastRequestPlayerBattleLogsTimeUseCase {
    func get() -> Int
    func set(lastRequestedTime: Int)
}

private struct LastRequestPlayerBattleLogsTimeUseCaseImpl: LastRequestPlayerBattleLogsTimeUseCase {

    private var repository: UserDefaultsRepository

    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }

    func get() -> Int {
        guard let lastRequestedTime: Int = self.repository.get(type: .lastRequestPlayerBattleLogsTime) else {
            return 0
        }
        return lastRequestedTime
    }

    func set(lastRequestedTime: Int) {
        self.repository.set(value: lastRequestedTime, type: .lastRequestPlayerBattleLogsTime)
    }
}
