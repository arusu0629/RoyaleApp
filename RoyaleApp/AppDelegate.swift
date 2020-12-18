//
//  AppDelegate.swift
//  RoyaleApp
//
//  Created by nakandakari on 2020/05/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Analytics
import Domain
import Presentation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.setup()

        return true
    }
}

// MARK: - Setup
private extension AppDelegate {

    func setup() {
        self.setupMigrate()
        self.setupFirebase()
        self.setupAd()
        //        self.setupPushNotification()
        self.setupBackgroundFetch()
    }
}

// MARK: - Setup migrate
private extension AppDelegate {

    func setupMigrate() {
        self.setupPlayerTagMigrate()
        self.setupRealmMigrateIfNeeded()
    }

    func setupPlayerTagMigrate() {
        AppConfig.migratePlayerTag()
    }

    func setupRealmMigrateIfNeeded() {
        if !AppConfig.alreadyMigrateBattleLog {
            RealmMigrateUseCaseProvider.provide(battleLogConfigName: Constant.battleLogConfigName, appGroupName: Constant.appGroupName).migrate { result in
                switch result {
                case .success:
                    AppConfig.alreadyMigrateBattleLog = true
                case .failure(let error):
                    // TODO: error handling
                    print("error = \(error)")
                }
            }
        }
    }
}

// MARK: - Setup Firebase
private extension AppDelegate {

    func setupFirebase() {
        FirebaseInitilizer.setup()
    }
}

// MARK: - Setup Ad
private extension AppDelegate {

    func setupAd() {
        AdManager.setup()
    }
}

// MARK: - Setup Push Notification
private extension AppDelegate {

    func setupPushNotification() {
        NotificationHelper.requestAuthorization()
    }
}

// MARK: - Setup BackgroundFetch
private extension AppDelegate {

    func setupBackgroundFetch() {
        BackgroundTaskManager.shared.registerBackgroundTask()
    }
}

// MARK: - Scene Lifecycle
extension AppDelegate {

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
