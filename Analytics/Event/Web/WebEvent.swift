//
//  WebEvent.swift
//  Analytics
//
//  Created by nakandakari on 2020/10/02.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import Foundation

public enum WebEvent {
    case display
    case selectWebTab(tab: WebViewTab)
}

extension WebEvent: AnalyticsEvent {

    public var name: String {
        switch self {
        case .display:
            return "web_display"
        case .selectWebTab:
            return "web_select_web_tab"
        }
    }

    public var properties: [AnyHashable : Any] {
        switch self {
        case .display:
            return [:]
        case .selectWebTab(let tab):
            return [AnalyticsManager.EventProperty.webViewTab.key: tab.label]
        }
    }
}
