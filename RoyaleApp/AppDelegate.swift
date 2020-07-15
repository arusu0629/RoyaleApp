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

        NotificationHelper.requestAuthorization(withDelegate: self)

        if #available(iOS 13.0, *) {
            BackgroundTaskManager.shared.registerBackgroundTask()
        }

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("token = \(token)")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NotificationHelper.postLocalNotification(with: Message(body: "Received Background Push"))
        DispatchQueue.main.async {
            completionHandler(.noData)
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    // 通知をタップして起動された際に呼ばれる
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("userNotificationCenter didReceive")
        completionHandler()
    }

    // アプリ起動中に通知を受信
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("userNotificationCenter willPresent")
        completionHandler([.alert, .badge, .sound])
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
