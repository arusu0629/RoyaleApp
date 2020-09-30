//
//  HomeEvent.swift
//  Analytics
//
//  Created by nakandakari on 2020/09/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import Foundation

public enum HomeEvent {
    case display
    case selectDateFilter(trophyDateFilter: TrophyDateFilter)
}

extension HomeEvent: AnalyticsEvent {

    public var name: String {
        switch self {
        case .display:
            return "home_display"
        case .selectDateFilter:
            return "home_select_trophy_date_filter"
        }
    }

    public var properties: [AnyHashable : Any] {
        switch self {
        case .display:
            return [:]
        case .selectDateFilter(let trophyDateFilter):
            return [AnalyticsManager.EventProperty.trophyDateFilter.key: trophyDateFilter.label]
        }
    }
}
