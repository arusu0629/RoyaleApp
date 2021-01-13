//
//  LastSelectedFilterDateIndexUseCase.swift
//  Domain
//
//  Created by nakandakari on 2021/01/12.
//

import DataStore
import Foundation

public enum LastSelectedFilterDateIndexUseCaseProvider {
    public static func provide() -> LastSelectedFilterDateIndexUseCase {
        return LastSelectedFilterDateIndexUseCaseImpl(repository: UserDefaultsRepositoryProvider.provide())
    }
}

public protocol LastSelectedFilterDateIndexUseCase {
    func get() -> Int
    func set(index: Int)
}

private struct LastSelectedFilterDateIndexUseCaseImpl: LastSelectedFilterDateIndexUseCase {

    private var repository: UserDefaultsRepository

    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }

    func get() -> Int {
        guard let index: Int = self.repository.get(type: .lastSelectedFilterDateIndex) else {
            return 0
        }
        return index
    }

    func set(index: Int) {
        self.repository.set(value: index, type: .lastSelectedFilterDateIndex)
    }
}
