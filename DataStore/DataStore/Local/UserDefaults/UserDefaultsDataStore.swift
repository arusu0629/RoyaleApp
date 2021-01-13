//
//  UserDefaultsDataStore.swift
//  DataStore
//
//  Created by nakandakari on 2021/01/06.
//

import Foundation

enum UserDefaultsDataStoreProvider {
    static func provide() -> UserDefaultsDataStore {
        return UserDefaultsDataStoreImpl()
    }
}

protocol UserDefaultsDataStore {
    func get<T>(type: UserDefaultsType) -> T?
    func get<T>(suiteName: String, type: UserDefaultsType) -> T?
    func set<T>(value: T, type: UserDefaultsType)
    func set<T>(suitName: String, value: T, type: UserDefaultsType)
}

private struct UserDefaultsDataStoreImpl: UserDefaultsDataStore {

    func get<T>(type: UserDefaultsType) -> T? {
        return UserDefaults().object(forKey: type.key) as? T
    }

    func get<T>(suiteName: String, type: UserDefaultsType) -> T? {
        return UserDefaults(suiteName: suiteName)?.object(forKey: type.key) as? T
    }

    func set<T>(value: T, type: UserDefaultsType) {
        UserDefaults.standard.set(value, forKey: type.key)
    }

    func set<T>(suitName: String, value: T, type: UserDefaultsType) {
        UserDefaults(suiteName: suitName)?.set(value, forKey: type.key)
    }
}
