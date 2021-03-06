//
//  RealmDeckModelUseCase.swift
//  Domain
//
//  Created by nakandakari on 2020/08/31.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation
import RealmSwift

public enum RealmDeckModelUseCaseProvider {

    public static func provide(deckModelConfigName: String, appGroupName: String) -> RealmDeckModelUseCase {
        return RealmDeckModelUseCaseImpl(realmUseCase: RealmUseCaseProvider.provide(configName: deckModelConfigName, appGroupName: appGroupName))
    }
}

public protocol RealmDeckModelUseCase {
    typealias Completion = (Result<Void, Error>) -> Void

    func save(object: RealmDeckModel)
    func get() -> Results<RealmDeckModel>?
    func deleteAll(completion: Completion)
}

private struct RealmDeckModelUseCaseImpl: RealmDeckModelUseCase {

    let realmUseCase: RealmUseCase

    func save(object: RealmDeckModel) {
        self.realmUseCase.save(object: object)
    }

    func get() -> Results<RealmDeckModel>? {
        return self.realmUseCase.get(with: RealmDeckModel.self)
    }

    func deleteAll(completion: Completion) {
        self.realmUseCase.deleteAll(completion: completion)
    }
}
