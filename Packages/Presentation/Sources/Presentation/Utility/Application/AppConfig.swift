//
//  AppConfig.swift
//  Domain
//
//  Created by nakandakari on 2020/06/08.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import Foundation

public class AppConfig {}

// MARK: - PlayerTag
extension AppConfig {

    public static func migratePlayerTag() {
        guard let playerTag = UserDefaults.standard.string(forKey: "playerTag"),
              !playerTag.isEmpty else {
            return
        }
        PlayerTagUseCaseProvider.provide().set(playerTag: playerTag)
        UserDefaults.standard.removeObject(forKey: "playerTag")
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
