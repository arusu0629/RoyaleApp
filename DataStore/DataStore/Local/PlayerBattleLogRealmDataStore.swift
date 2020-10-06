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

    static func provide(configName: String) -> RealmDataStore {
        return RealmDataStoreImpl(configName: configName)
    }
}

protocol RealmDataStore {
    typealias Completion = (Result<Void, Error>) -> Void

    func save<T: Object>(object: T)
    func save<T: Object>(objects: [T])
    func get<T: Object>(with type: T.Type) -> Results<T>?
    func deleteAll(completion: Completion)
    var configName: String { get set }
}

private struct RealmDataStoreImpl: RealmDataStore {

    var configName: String

    init(configName: String) {
        self.configName = configName
    }

    func save<T>(object: T) where T : Object {

        guard let realm = self.realm() else {
            return
        }
        try? realm.write {
            realm.add(object, update: .all)
        }
    }

    func save<T>(objects: [T]) where T : Object {
        guard let realm = self.realm() else {
            return
        }
        try? realm.write {
            realm.add(objects, update: .all)
        }
    }

    func get<T>(with type: T.Type) -> Results<T>? where T : Object {
        guard let realm = self.realm() else {
            return nil
        }
        return realm.objects(type.self)
    }

    func deleteAll(completion: (Result<Void, Error>) -> Void) {
        guard let realm = self.realm() else {
            completion(.failure(RealmDataStoreError.instance))
            return
        }
        do {
            try realm.write {
                realm.deleteAll()
                completion(.success(()))
            }
        } catch {
            completion(.failure(RealmDataStoreError.failedDelete))
        }
    }

    private func realm() -> Realm? {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(self.configName).realm")
        return try? Realm(configuration: config)
    }

}
