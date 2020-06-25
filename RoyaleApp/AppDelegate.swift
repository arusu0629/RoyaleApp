//
//  AppDelegate.swift
//  RoyaleApp
//
//  Created by nakandakari on 2020/05/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Presentation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    @available(iOS, deprecated: 13.0)
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setupWindowIfNeeded()
        return true
    }
}

// MARK: - Setup Window
extension AppDelegate {

    private func setupWindowIfNeeded() {
        if #available(iOS 13.0, *) {
        } else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let navigationController = UINavigationController(rootViewController: self.rootViewController())
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
    }

    private func rootViewController() -> UIViewController {
        return RootBuilder.build()
    }
}

// MARK: - URL Scheme
extension AppDelegate {

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
}

// MARK: - Scene Lifecycle
@available(iOS 13.0, *)
extension AppDelegate {

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
