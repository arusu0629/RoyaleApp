//
//  AdNetwork.swift
//  Analytics
//
//  Created by nakandakari on 2020/10/01.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Analytics
import Foundation

public enum AdNetwork {
    case admob(id: String)
}

extension AdNetwork {

    public static func all() -> [AdNetwork] {
        return [
            adMob()
        ]
    }

    private static func adMob() -> AdNetwork {
        #if DEBUG
        return admob(id: "ca-app-pub-3940256099942544/2934735716")
        #else
        return admob(id: FirebaseRemoteConfigManager.getAdMobAdUnitId())
        #endif
    }
}
