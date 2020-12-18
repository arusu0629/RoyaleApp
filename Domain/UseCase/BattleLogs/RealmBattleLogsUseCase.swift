//
//  RealmBattleLogsUseCase.swift
//  Domain
//
//  Created by nakandakari on 2020/07/08.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation
import RealmSwift

public enum RealmBattleLogsUseCaseProvider {

    public static func provide(battleLogConfigName: String, appGroupName: String) -> RealmBattleLogsUseCase {
        return RealmBattleLogsUseCaseImpl(realmUseCase: RealmUseCaseProvider.provide(configName: battleLogConfigName, appGroupName: appGroupName))
    }
}

public protocol RealmBattleLogsUseCase {
    typealias Completion = (Result<Void, Error>) -> Void

    func save(object: RealmBattleLogModel)
    func save(objects: [RealmBattleLogModel])
    func get() -> Results<RealmBattleLogModel>?
    func getLatest() -> RealmBattleLogModel?
    func deleteAll(completion: Completion)
}

private struct RealmBattleLogsUseCaseImpl: RealmBattleLogsUseCase {

    let realmUseCase: RealmUseCase

    func save(object: RealmBattleLogModel) {
        self.realmUseCase.save(object: object)
    }

    func save(objects: [RealmBattleLogModel]) {
        self.realmUseCase.save(objects: objects)
    }

    func get() -> Results<RealmBattleLogModel>? {
        return self.realmUseCase.get(with: RealmBattleLogModel.self)
    }

    func getLatest() -> RealmBattleLogModel? {
        guard let realmBattleLogs = self.get() else {
            return nil
        }
        let sortedBattleLogs = [RealmBattleLogModel](realmBattleLogs.sorted(byKeyPath: RealmBattleLogModel.sortedKey))
        if sortedBattleLogs.isEmpty {
            return nil
        }
        return sortedBattleLogs[sortedBattleLogs.count - 1]
    }

    func deleteAll(completion: Completion) {
        self.realmUseCase.deleteAll(completion: completion)
    }
}
