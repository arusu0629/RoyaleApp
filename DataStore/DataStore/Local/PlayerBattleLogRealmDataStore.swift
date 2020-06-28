//
//  RealmDataStore.swift
//  DataStore
//
//  Created by nakandakari on 2020/06/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmDataStoreProvider {

    static func provide() -> RealmDataStore {
        return RealmDataStoreImpl()
    }
}

protocol RealmDataStore {
    func save<T: Object>(object: T)
    func save<T: Object>(objects: [T])
    func get<T: Object>(with type: T.Type) -> Results<T>?
}

private struct RealmDataStoreImpl: RealmDataStore {

    func save<T>(object: T) where T : Object {

        guard let realm = try? Realm() else {
            return
        }
        try? realm.write {
            realm.add(object, update: .all)
        }
    }

    func save<T>(objects: [T]) where T : Object {
        guard let realm = try? Realm() else {
            return
        }
        try? realm.write {
            realm.add(objects, update: .all)
        }
    }

    func get<T>(with type: T.Type) -> Results<T>? where T : Object {
        guard let realm = try? Realm() else {
            return nil
        }
        return realm.objects(type.self)
    }
}
