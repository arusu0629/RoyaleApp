//
//  AnalyticsManager.swift
//  Analytics
//
//  Created by nakandakari on 2020/09/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import FirebaseAnalytics
import Foundation

public protocol AnalyticsEvent {
    var name: String { get }
    var properties: [AnyHashable: Any] { get }
}

public final class AnalyticsManager {

    public static func sendEvent(_ event: AnalyticsEvent) {
        sendEvent(name: event.name, property: event.properties as? [String: Any])
    }

    private static func sendEvent(name: String, property: [String: Any]? = nil) {
        Analytics.logEvent(name, parameters: property)
    }
}

extension AnalyticsManager {

    enum EventProperty {
        case trophyDateFilter
        case deckCardIds
        case cardSortType

        var key: String {
            switch self {
            case .trophyDateFilter:
                return "date_filter"
            case .deckCardIds:
                return "deck_card_ids"
            case .cardSortType:
                return "deckcreate_card_sort_type"
            }
        }
    }
}
