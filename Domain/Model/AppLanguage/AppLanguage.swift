//
//  AppLanguage.swift
//  Domain
//
//  Created by nakandakari on 2021/09/14.
//

import Foundation

public enum AppLanguage: Int, CaseIterable {
    case en = 0
    case ja
}

public extension AppLanguage {

    static var defaultLanguage: AppLanguage {
        return .en
    }

    var description: String {
        switch self {
        case .en : return "English"
        case .ja : return "日本語"
        }
    }
}
