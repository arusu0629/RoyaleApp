//
//  RealmUseCase.swift
//  Domain
//
//  Created by nakandakari on 2020/06/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation
import RealmSwift

enum RealmUseCaseProvider {

    static func provide(configName: String, appGroupName: String) -> RealmUseCase {
        return RealmUseCaseImpl(repository: RealmRepositoryProvider.provide(configName: configName, appGroupName: appGroupName))
    }
}

protocol RealmUseCase {
    typealias Completion = (Result<Void, Error>) -> Void

    func save<T: Object>(object: T)
    func save<T: Object>(objects: [T])
    func get<T: Object>(with type: T.Type) -> Results<T>?
    func deleteAll(completion: Completion)
}

private struct RealmUseCaseImpl: RealmUseCase {

    let repository: RealmRepository

    func save<T>(object: T) where T : Object {
        self.repository.save(object: object)
    }

    func save<T>(objects: [T]) where T : Object {
        self.repository.save(objects: objects)
    }

    func get<T>(with type: T.Type) -> Results<T>? where T : Object {
        return self.repository.get(with: type)
    }

    func deleteAll(completion: Completion) {
        self.repository.deleteAll(completion: completion)
    }
}
