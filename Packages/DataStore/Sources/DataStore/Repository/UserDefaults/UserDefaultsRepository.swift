//
//  UserDefaultsRepository.swift
//  DataStore
//
//  Created by nakandakari on 2021/01/07.
//

import Foundation

public enum UserDefaultsRepositoryProvider {
    public static func provide() -> UserDefaultsRepository {
        return UserDefaultsRepositoryImpl(userDefaultsDataStore: UserDefaultsDataStoreProvider.provide())
    }
}

public protocol UserDefaultsRepository {
    func get<T>(type: UserDefaultsType) -> T?
    func get<T>(suitName: String, type: UserDefaultsType) -> T?
    func set<T>(value: T, type: UserDefaultsType)
    func set<T>(suitName: String, value: T, type: UserDefaultsType)
}

private struct UserDefaultsRepositoryImpl: UserDefaultsRepository {

    private let userDefaultsDataStore: UserDefaultsDataStore

    init(userDefaultsDataStore: UserDefaultsDataStore) {
        self.userDefaultsDataStore = userDefaultsDataStore
    }

    func get<T>(type: UserDefaultsType) -> T? {
        return self.userDefaultsDataStore.get(type: type)
    }

    func get<T>(suitName: String, type: UserDefaultsType) -> T? {
        return self.userDefaultsDataStore.get(suiteName: suitName, type: type)
    }

    func set<T>(value: T, type: UserDefaultsType) {
        self.userDefaultsDataStore.set(value: value, type: type)
    }

    func set<T>(suitName: String, value: T, type: UserDefaultsType) {
        self.userDefaultsDataStore.set(suitName: suitName, value: value, type: type)
    }
}
