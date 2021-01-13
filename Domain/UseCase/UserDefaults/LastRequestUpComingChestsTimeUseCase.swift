//
//  LastRequestUpComingChestsTimeUseCase.swift
//  Domain
//
//  Created by nakandakari on 2021/01/14.
//

import DataStore
import Foundation

public enum LastRequestUpComingChestsTimeUseCaseProvider {
    public static func provide() -> LastRequestUpComingChestsTimeUseCase {
        return LastRequestUpComingChestsTimeUseCaseImpl(repository: UserDefaultsRepositoryProvider.provide())
    }
}

public protocol LastRequestUpComingChestsTimeUseCase {
    func get() -> Int
    func set(lastRequestedTime: Int)
}

private struct LastRequestUpComingChestsTimeUseCaseImpl: LastRequestUpComingChestsTimeUseCase {

    private var repository: UserDefaultsRepository

    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }

    func get() -> Int {
        guard let lastRequestedTime: Int = self.repository.get(type: .lastRequestUpComingChestsTime) else {
            return 0
        }
        return lastRequestedTime
    }

    func set(lastRequestedTime: Int) {
        self.repository.set(value: lastRequestedTime, type: .lastRequestUpComingChestsTime)
    }
}
