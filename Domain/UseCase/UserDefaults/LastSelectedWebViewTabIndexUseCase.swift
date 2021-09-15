//
//  LastSelectedWebViewTabIndexUseCase.swift
//  Domain
//
//  Created by nakandakari on 2021/01/12.
//

import DataStore
import Foundation

public enum LastSelectedWebViewTabIndexUseCaseProvider {
    public static func provide() -> LastSelectedWebViewTabIndexUseCase {
        return LastSelectedWebViewTabIndexUseCaseImpl(repository: UserDefaultsRepositoryProvider.provide())
    }
}

public protocol LastSelectedWebViewTabIndexUseCase {
    func get() -> Int
    func set(index: Int)
}

private struct LastSelectedWebViewTabIndexUseCaseImpl: LastSelectedWebViewTabIndexUseCase {

    private var repository: UserDefaultsRepository

    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }

    func get() -> Int {
        guard let index: Int = self.repository.get(type: .lastSelectedWebViewTabIndex) else {
            return 0
        }
        return index
    }

    func set(index: Int) {
        self.repository.set(value: index, type: .lastSelectedWebViewTabIndex)
    }
}