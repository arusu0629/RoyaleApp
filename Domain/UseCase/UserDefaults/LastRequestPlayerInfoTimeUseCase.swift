//
//  LastRequestPlayerInfoTimeUseCase.swift
//  Domain
//
//  Created by nakandakari on 2021/01/13.
//

import DataStore
import Foundation

public enum LastRequestPlayerInfoTimeUseCaseProvider {
    public static func provide() -> LastRequestPlayerInfoTimeUseCase {
        return LastRequestPlayerInfoTimeUseCaseImpl(repository: UserDefaultsRepositoryProvider.provide())
    }
}

public protocol LastRequestPlayerInfoTimeUseCase {
    func get() -> Int
    func set(lastRequestedTime: Int)
}

private struct LastRequestPlayerInfoTimeUseCaseImpl: LastRequestPlayerInfoTimeUseCase {

    private var repository: UserDefaultsRepository

    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }

    func get() -> Int {
        guard let lastRequestedTime: Int = self.repository.get(type: .lastRequestPlayerInfoTime) else {
            return 0
        }
        return lastRequestedTime
    }

    func set(lastRequestedTime: Int) {
        self.repository.set(value: lastRequestedTime, type: .lastRequestPlayerInfoTime)
    }
}
