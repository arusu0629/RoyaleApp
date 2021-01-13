//
//  TodaysResultWidgetInfo.swift
//  TodaysTrophyGraphWidgetExtension
//
//  Created by nakandakari on 2020/12/09.
//

import Domain
import Foundation

struct TodaysResultWidgetInfo {
    let win                : Int
    let lose               : Int
    let draw               : Int
    let totalTrophyChanges : Int
    let currentTrophy      : Int

    var trophyChangesLabel: String {
        if self.totalTrophyChanges <= 0 {
            return "\(self.totalTrophyChanges)"
        }
        return "+\(self.totalTrophyChanges)"
    }

    private init(win: Int, lose: Int, draw: Int, totalTrophyChanges: Int, currentTrophy: Int) {
        self.win                = win
        self.lose               = lose
        self.draw               = draw
        self.totalTrophyChanges = totalTrophyChanges
        self.currentTrophy      = currentTrophy
    }

    init(battleLogs: [RealmBattleLogModel]) {
        self.win                = battleLogs.filter { $0.trophyChange > 0 }.count
        self.lose               = battleLogs.filter { $0.trophyChange < 0 }.count
        self.draw               = battleLogs.filter { $0.trophyChange == 0 }.count
        self.totalTrophyChanges = battleLogs.reduce(0) { $0 + $1.trophyChange }
        self.currentTrophy      = battleLogs.last?.afterTrophy ?? 0
    }
}

extension TodaysResultWidgetInfo {

    static func dummyData() -> TodaysResultWidgetInfo {
        return TodaysResultWidgetInfo(win: 10, lose: 2, draw: 0, totalTrophyChanges: 40, currentTrophy: 2302)
    }
}
