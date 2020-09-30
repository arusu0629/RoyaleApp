//
//  FirebaseInitilizer.swift
//  Analytics
//
//  Created by nakandakari on 2020/09/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Firebase
import Foundation

public enum FirebaseInitilizer {

    public static func setup() {
        FirebaseApp.configure()
        FirebaseRemoteConfigManager.setup()
    }
}
