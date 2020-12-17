//
//  TodaysResultUseCase.swift
//  RoyaleAppWidget
//
//  Created by nakandakari on 2020/12/17.
//

import Domain
import Foundation

enum TodaysResultUseCaseProvider {
    static func provide() -> TodaysResultUseCase {
        return TodaysResultUseCaseImpl(
            realmBattleLogsUseCase: RealmBattleLogsUseCaseProvider.provide(),
            battleLogsUseCase: BattleLogsUseCaseProvider.provide()
        )
    }
}

protocol TodaysResultUseCase {
    typealias Completion = ((TodaysResultWidgetInfo) -> Void)
    func get(completion: @escaping Completion)
}

private struct TodaysResultUseCaseImpl: TodaysResultUseCase {

    private let realmBattleLogsUseCase: RealmBattleLogsUseCase
    private let battleLogsUseCase: BattleLogsUseCase

    init(realmBattleLogsUseCase: RealmBattleLogsUseCase, battleLogsUseCase: BattleLogsUseCase) {
        self.realmBattleLogsUseCase = realmBattleLogsUseCase
        self.battleLogsUseCase = battleLogsUseCase
    }

    func get(completion: @escaping Completion) {
        self.requestBattleLogs {
            completion(self.createTodaysResultInfo())
        }
    }

    private func requestBattleLogs(completion: @escaping (() -> Void)) {
        self.battleLogsUseCase.get(playerTag: AppConfig.playerTag) { result in
            switch result {
            case .success(let battleLogsModel):
                let realmBattleLogs = battleLogsModel.realmBattleLogs()
                self.realmBattleLogsUseCase.save(objects: realmBattleLogs)
                completion()
            case .failure:
                completion()
            }
        }
    }

    private func createTodaysResultInfo() -> TodaysResultWidgetInfo {
        guard let battleLogsModels = self.realmBattleLogsUseCase.get() else {
            return TodaysResultWidgetInfo(battleLogs: [])
        }

        var realmBattleLogs = [RealmBattleLogModel](battleLogsModels.sorted(byKeyPath: RealmBattleLogModel.sortedKey))
        let filterDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        realmBattleLogs = realmBattleLogs.filter { $0.battleDate >= filterDate }
        return TodaysResultWidgetInfo(battleLogs: realmBattleLogs)
    }
}
