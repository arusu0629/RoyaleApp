//
//  BattleLogsModel.swift
//  Domain
//
//  Created by nakandakari on 2020/06/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation

public struct BattleLogsModel {
    public let battleLogs: [CRPlayerBattleLog]
}

extension BattleLogsModel {

    init(_ battleLogs: [CRPlayerBattleLog]) {
        self.battleLogs = battleLogs
    }
}
