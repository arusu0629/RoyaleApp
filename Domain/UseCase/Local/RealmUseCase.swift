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

public enum RealmUseCaseProvider {

    public static func provide() -> RealmUseCase {
        return RealmUseCaseImpl(repository: RealmRepositoryProvider.provide())
    }
}

public protocol RealmUseCase {
    func save<T: Object>(object: T)
    func save<T: Object>(objects: [T])
}

private struct RealmUseCaseImpl: RealmUseCase {

    let repository: RealmRepository

    func save<T>(object: T) where T : Object {
        self.repository.save(object: object)
    }

    func save<T>(objects: [T]) where T : Object {
        self.repository.save(objects: objects)
    }
}
