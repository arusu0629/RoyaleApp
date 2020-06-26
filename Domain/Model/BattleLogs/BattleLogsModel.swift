//
//  BattleLogsModel.swift
//  Domain
//
//  Created by nakandakari on 2020/06/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation
import RealmSwift

public final class RealmBattleLogModel: Object {
    @objc dynamic var gameMode: String = ""
    @objc dynamic var beforeTrophy: Int = 0
    @objc dynamic var trophyChange: Int = 0
    @objc dynamic var afterTrophy: Int = 0
    @objc dynamic var battleTime: String = ""

    public override class func primaryKey() -> String? {
        return "battleTime"
    }
}

public struct BattleLogsModel {
    let battleLogs: [CRPlayerBattleLog]
}

extension BattleLogsModel {

    init(_ battleLogs: [CRPlayerBattleLog]) {
        self.battleLogs = battleLogs
    }
}

// MARK: - RealmBattleLogModel
public extension BattleLogsModel {

    func realmBattleLogs() -> [RealmBattleLogModel] {
        var realmBattleLogs: [RealmBattleLogModel] = []
        for battleLog in self.battleLogs {
            realmBattleLogs.append(self.realmBattleLog(from: battleLog))
        }
        return realmBattleLogs
    }

    private func realmBattleLog(from battleLog: CRPlayerBattleLog) -> RealmBattleLogModel {
        let realmBattleLogModel = RealmBattleLogModel()

        // GameMode
        realmBattleLogModel.gameMode = battleLog.gameMode?.name ?? "Invalid Game Mode"

        // Trophy
        if let team = battleLog.team {
            realmBattleLogModel.beforeTrophy = team[0].startingTrophies ?? 0
            realmBattleLogModel.trophyChange = team[0].trophyChange ?? 0
            realmBattleLogModel.afterTrophy = realmBattleLogModel.beforeTrophy + realmBattleLogModel.trophyChange
        }

        // BattleTime
        realmBattleLogModel.battleTime = self.formatBattleTime(battleLog.battleTime)
        return realmBattleLogModel
    }

    // TODO: ここに書いて良いのか感
    private func formatBattleTime(_ battleTime: String?) -> String {
        let en_US_Formatter = DateFormatter()
        en_US_Formatter.locale = Locale(identifier: "en_US_POSIX")
        en_US_Formatter.dateFormat = "yyyyMMdd'T'HHmmss'.'000Z'"
        en_US_Formatter.timeZone = TimeZone(secondsFromGMT: 0)

        let ja_JP_Formatter = DateFormatter()
        ja_JP_Formatter.locale = Locale(identifier: "ja_JP")
        ja_JP_Formatter.timeStyle = .medium
        ja_JP_Formatter.dateStyle = .medium

        guard let battleTime = battleTime else {
            return "\(Date(timeIntervalSince1970: 0))"
        }

        guard let utcDate = en_US_Formatter.date(from: battleTime) else {
            return "\(Date(timeIntervalSince1970: 0))"
        }
        return ja_JP_Formatter.string(from: utcDate)
    }
}
