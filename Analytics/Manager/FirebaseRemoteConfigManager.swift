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

        // 即時更新
        var duration = 0
        #if !DEBUG
        duration = 60 * 60
        #endif
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
        let token = fetchStringValue(key: apiTokenKey)
        if token.isEmpty {
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

    public static func getAdMobMovieRewardId() -> String {
        let key = "admob_movie_reward_id"
        return fetchStringValue(key: key)
    }
}

// MARK: - WebView
extension FirebaseRemoteConfigManager {

    public static func getClassicChallengeWebViewUrl() -> String {
        let key = "classic_challenge_web_url"
        return fetchStringValue(key: key)
    }

    public static func getGrandChallengeWebViewUrl() -> String {
        let key = "grand_challenge_web_url"
        return fetchStringValue(key: key)
    }

    public static func getTopLadderWebViewUrl() -> String {
        let key = "top_ladder_web_url"
        return fetchStringValue(key: key)
    }
}
