//
//  TrophyDateFilter.swift
//  Domain
//
//  Created by nakandakari on 2020/07/17.
//  Copyright © 2020 nakandakari. All rights reserved.
//

public enum TrophyDateFilter: Int, CaseIterable {
    case today
    case weekly
    case monthly
    case year

    public var analyticsEventValue: String {
        switch self {
        case .today   : return "Today"
        case .weekly  : return "Weekly"
        case .monthly : return "Monthly"
        case .year    : return "Year"
        }
    }

    public var filterDate: Date {
        let now = Date()
        switch self {
        case .today:   return Calendar.current.date(byAdding: .day, value: -1, to: now)!
        case .weekly:  return Calendar.current.date(byAdding: .day, value: -7, to: now)!
        case .monthly: return Calendar.current.date(byAdding: .month, value: -1, to: now)!
        case .year:    return Calendar.current.date(byAdding: .year, value: -1, to: now)!
        }
    }
}
