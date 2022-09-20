//
//  LastSelectedDeckIndex.swift
//  Domain
//
//  Created by nakandakari on 2021/01/12.
//

import DataStore
import Foundation

public enum LastSelectedDeckIndexUseCaseProvider {
    public static func provide() -> LastSelectedDeckIndexUseCase {
        return LastSelectedDeckIndexUseCaseImpl(repository: UserDefaultsRepositoryProvider.provide())
    }
}

public protocol LastSelectedDeckIndexUseCase {
    func get() -> Int
    func set(index: Int)
}

private struct LastSelectedDeckIndexUseCaseImpl: LastSelectedDeckIndexUseCase {

    private var repository: UserDefaultsRepository

    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }

    func get() -> Int {
        guard let index: Int = self.repository.get(type: .lastSelctedDeckIndex) else {
            return 0
        }
        return index
    }

    func set(index: Int) {
        self.repository.set(value: index, type: .lastSelctedDeckIndex)
    }
}
