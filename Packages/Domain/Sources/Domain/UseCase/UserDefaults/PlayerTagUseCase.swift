//
//  PlayerTagUseCase.swift
//  Domain
//
//  Created by nakandakari on 2021/01/07.
//

import DataStore
import Foundation

public enum PlayerTagUseCaseProvider {
    public static func provide() -> PlayerTagUseCase {
        return PlayerTagUseCaseImpl(repository: UserDefaultsRepositoryProvider.provide())
    }
}

public protocol PlayerTagUseCase {
    func get() -> String
    func set(playerTag: String)
}

private struct PlayerTagUseCaseImpl: PlayerTagUseCase {

    private let repository: UserDefaultsRepository

    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }

    func get() -> String {
        guard let playerTag: String = self.repository.get(suitName: DataStoreConstant.appGroupName, type: .playerTag) else {
            return ""
        }
        return playerTag
    }

    func set(playerTag: String) {
        self.repository.set(suitName: DataStoreConstant.appGroupName, value: playerTag, type: .playerTag)
    }
}
