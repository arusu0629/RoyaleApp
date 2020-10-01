//
//  FirebaseRemoteConfigManager.swift
//  Analytics
//
//  Created by nakandakari on 2020/09/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import FirebaseRemoteConfig
import Foundation

public enum FirebaseRemoteConfigManager {}

extension FirebaseRemoteConfigManager {

    public static func setup() {
        fetchValues()
    }

    private static func fetchValues() {
        let remoteConfig = RemoteConfig.remoteConfig()

        // TODO: 本番環境だと1時間以上空けるようにする
        let duration = 0 // 即時更新
        remoteConfig.fetch(withExpirationDuration: TimeInterval(duration), completionHandler: {(state, _) in
            switch state {
            case .success:
                remoteConfig.activate(completion: nil)
                fetchAndSaveApiToken()
            default:
                break // 失敗した場合デフォルト値になる.
            }
        })
    }

    private static func fetchAndSaveApiToken() {
        let apiTokenKey = "api_token_key"
        let remoteConfig = RemoteConfig.remoteConfig()
        guard let token = remoteConfig[apiTokenKey].stringValue, !token.isEmpty else {
            return
        }
        DataStoreConfig.token = token
    }

    private static func fetchStringValue(key: String) -> String {
        let remoteConfig = RemoteConfig.remoteConfig()
        return remoteConfig[key].stringValue ?? ""
    }
}

// MARK: - AdMob AdUnitId
extension FirebaseRemoteConfigManager {

    public static func getAdMobAdUnitId() -> String {
        let key = "admob_adunit_id"
        return fetchStringValue(key: key)
    }
}
