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
    func migrate(completion: Completion)
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

    func deleteAll(completion: Completion) {
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
        config.fileURL = self.configUrl
        return try? Realm(configuration: config)
    }

    public func migrate(completion: Completion) {
        var oldConfig = Realm.Configuration()
        oldConfig.fileURL = self.oldConfigUrl
        let realm = try? Realm(configuration: oldConfig)
        do {
            try FileManager.default.removeItem(at: self.configUrl)
            try realm?.writeCopy(toFile: self.configUrl)
            completion(.success(()))
        } catch {
            completion(.failure(RealmDataStoreError.failedMigrate))
        }
    }

    private var oldConfigUrl: URL {
        let oldConfig = Realm.Configuration()
        return oldConfig.fileURL!.deletingLastPathComponent().appendingPathComponent("\(self.configName).realm")
    }

    private var configUrl: URL {
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constant.appGroup)!
        return url.appendingPathComponent("\(self.configName).realm")
    }
}
