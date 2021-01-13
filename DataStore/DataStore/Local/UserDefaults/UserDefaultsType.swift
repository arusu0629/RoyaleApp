//
//  UserDefaultsType.swift
//  DataStore
//
//  Created by nakandakari on 2021/01/06.
//

import Foundation

public enum UserDefaultsType: String {
    case playerTag
    case lastSelectedFilterDateIndex
    case lastSelctedDeckIndex
    case lastSelectedSortIndex
    case lastSelectedWebViewTabIndex
    case lastRequestPlayerInfoTime
    case lastRequestPlayerBattleLogsTime
    case lastRequestUpComingChestsTime
    case alreadyMigrateBattleLog
}

extension UserDefaultsType {

    var key: String {
        switch self {
        case .playerTag:
            return self.rawValue + DataStoreConstant.playerTagVersion
        case .lastSelectedFilterDateIndex,
             .lastSelctedDeckIndex,
             .lastSelectedSortIndex,
             .lastSelectedWebViewTabIndex,
             .lastRequestPlayerInfoTime,
             .lastRequestPlayerBattleLogsTime,
             .lastRequestUpComingChestsTime,
             .alreadyMigrateBattleLog:
            return self.rawValue
        }
    }
}
