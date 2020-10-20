//
//  FirebaseInitilizer.swift
//  Analytics
//
//  Created by nakandakari on 2020/09/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import FirebaseCore
import Foundation

public enum FirebaseInitilizer {

    public static func setup() {
        if let options = firebaseOptions {
            FirebaseApp.configure(options: options)
        } else {
            FirebaseApp.configure()
        }
        FirebaseRemoteConfigManager.setup()
    }

    private static var firebaseOptions: FirebaseOptions? {
        var fileName = ""
        #if DEBUG
        fileName = "GoogleService-Info-Dev"
        #else
        fileName = "GoogleService-Info"
        #endif

        guard let file = Bundle.main.path(forResource: fileName, ofType: "plist") else {
            return nil
        }

        return FirebaseOptions(contentsOfFile: file)!
    }
}
