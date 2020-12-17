//
//  AppConfig.swift
//  Domain
//
//  Created by nakandakari on 2020/06/08.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public class AppConfig {}

// MARK: - UserDefaults
extension AppConfig {

    public static var lastSelectedFilterDateIndex: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
        get {
            return UserDefaults.standard.integer(forKey: #function)
        }
    }

    public static var lastSelectedDeckIndex: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
        get {
            return UserDefaults.standard.integer(forKey: #function)
        }
    }

    public static var lastSelectedSortIndex: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
        get {
            return UserDefaults.standard.integer(forKey: #function)
        }
    }

    public static var lastSelectedWebViewTabIndex: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
        get {
            return UserDefaults.standard.integer(forKey: #function)
        }
    }

    public static var lastRequestPlayerInfoTime: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
        get {
            return UserDefaults.standard.integer(forKey: #function)
        }
    }

    public static var lastRequestPlayerBattleLogsTime: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
        get {
            return UserDefaults.standard.integer(forKey: #function)
        }
    }

    public static var lastRequestUpComingChestsTime: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
        get {
            return UserDefaults.standard.integer(forKey: #function)
        }
    }
}

// MARK: - PlayerTag
extension AppConfig {

    private static let playerTagVersion = "_v1"

    public static var playerTag: String {
        set {
            UserDefaults(suiteName: Constant.appGroup)?.set(newValue, forKey: #function + playerTagVersion)
        }
        get {
            return UserDefaults(suiteName: Constant.appGroup)?.string(forKey: #function + playerTagVersion) ?? ""
        }
    }

    public static func migratePlayerTag() {
        self.playerTag = UserDefaults.standard.string(forKey: "playerTag") ?? ""
    }

    /// Note that player tags start with hash character '#' and that needs to be URL-encoded properly to work in URL, so for example player tag '#2ABC' would become '%232ABC' in the URL.
    static func convertPlayerTag(_ playerTag: String) -> String {
        let specialCharacter = "#"
        let replaceCharacter = "%23"

        if !playerTag.starts(with: specialCharacter) {
            return playerTag
        }
        var convertPlayerTag = playerTag
        convertPlayerTag.removeFirst()

        return replaceCharacter + convertPlayerTag
    }
}
