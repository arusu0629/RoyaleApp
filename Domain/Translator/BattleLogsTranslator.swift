//
//  BattleLogsTranslator.swift
//  Domain
//
//  Created by nakandakari on 2020/06/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation

enum BattleLogsTranslatorProvider {
    static func provide() -> BattleLogsTranslator {
        return BattleLogsTranslatorImpl()
    }
}

protocol BattleLogsTranslator {
    func convert(from responses: [CRPlayerBattleLog]) -> BattleLogsModel
}

private struct BattleLogsTranslatorImpl: BattleLogsTranslator {

    func convert(from responses: [CRPlayerBattleLog]) -> BattleLogsModel {
        return BattleLogsModel(battleLogs: responses)
    }
}
