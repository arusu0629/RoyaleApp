//
//  MovieRewardNetwork.swift
//  Presentation
//
//  Created by nakandakari on 2020/10/11.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Analytics
import Foundation

public enum MovieRewardNetwork {
    case admob(id: String)
}

extension MovieRewardNetwork {

    public static func all() -> [MovieRewardNetwork] {
        return [
            adMob()
        ]
    }

    private static func adMob() -> MovieRewardNetwork {
        #if DEBUG
        return admob(id: "ca-app-pub-3940256099942544/1712485313")
        #else
        return admob(id: FirebaseRemoteConfigManager.getAdMobMovieRewardId())
        #endif
    }
}
