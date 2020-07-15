//
//  NotificationHelper.swift
//  Presentation
//
//  Created by nakandakari on 2020/07/07.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

public final class NotificationHelper {

    public static func requestAuthorization(withDelegate delegate: UNUserNotificationCenterDelegate? = nil) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
            if error != nil {
                return
            }

            if granted {
                UNUserNotificationCenter.current().delegate = delegate
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        })
    }

    public static func postLocalNotification(with message: Message) {
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: {
                                                let content = UNMutableNotificationContent()
                                                if let title = message.title {
                                                    content.title = title
                                                }
                                                if let subtitle = message.subtitle {
                                                    content.subtitle = subtitle
                                                }
                                                content.body = message.body
                                                return content
        }(),
                                            trigger: UNTimeIntervalNotificationTrigger(timeInterval: 3.0, repeats: false))
        DispatchQueue.main.async {
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
}

public struct Message {
    let title: String?
    let subtitle: String?
    let body: String

    public init(title: String? = nil, subtitle: String? = nil, body: String) {
        self.title = title
        self.subtitle = subtitle
        self.body = body
    }
}
