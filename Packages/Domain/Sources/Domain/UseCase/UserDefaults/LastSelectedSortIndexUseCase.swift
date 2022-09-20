//
//  LastSelectedSortIndexUseCase.swift
//  Domain
//
//  Created by nakandakari on 2021/01/12.
//

import DataStore
import Foundation

public enum LastSelectedSortIndexUseCaseProvider {
    public static func provide() -> LastSelectedSortIndexUseCase {
        return LastSelectedSortIndexUseCaseImpl(repository: UserDefaultsRepositoryProvider.provide())
    }
}

public protocol LastSelectedSortIndexUseCase {
    func get() -> Int
    func set(index: Int)
}

private struct LastSelectedSortIndexUseCaseImpl: LastSelectedSortIndexUseCase {

    private var repository: UserDefaultsRepository

    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }

    func get() -> Int {
        guard let index: Int = self.repository.get(type: .lastSelectedSortIndex) else {
            return 0
        }
        return index
    }

    func set(index: Int) {
        self.repository.set(value: index, type: .lastSelectedSortIndex)
    }
}
