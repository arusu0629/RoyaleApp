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

    private static let configName: String = "DeckModel"

    public static func provide() -> RealmDeckModelUseCase {
        return RealmDeckModelUseCaseImpl(realmUseCase: RealmUseCaseProvider.provide(configName: RealmDeckModelUseCaseProvider.configName))
    }
}

public protocol RealmDeckModelUseCase {
    func save(object: RealmDeckModel)
    func get() -> Results<RealmDeckModel>?
}

private struct RealmDeckModelUseCaseImpl: RealmDeckModelUseCase {

    let realmUseCase: RealmUseCase

    func save(object: RealmDeckModel) {
        self.realmUseCase.save(object: object)
    }

    func get() -> Results<RealmDeckModel>? {
        return self.realmUseCase.get(with: RealmDeckModel.self)
    }
}