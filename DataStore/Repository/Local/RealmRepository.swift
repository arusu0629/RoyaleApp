//
//  RealmRepository.swift
//  DataStore
//
//  Created by nakandakari on 2020/06/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation
import RealmSwift

public enum RealmRepositoryProvider {

    public static func provide() -> RealmRepository {
        return RealmRepositoryImpl(realmDataStore: RealmDataStoreProvider.provide())
    }
}

public protocol RealmRepository {
    func save<T: Object>(object: T)
    func save<T: Object>(objects: [T])
}

private struct RealmRepositoryImpl: RealmRepository {

    let realmDataStore: RealmDataStore

    func save<T>(object: T) where T : Object {
        self.realmDataStore.save(object: object)
    }

    func save<T>(objects: [T]) where T : Object {
        self.realmDataStore.save(objects: objects)
    }
}
