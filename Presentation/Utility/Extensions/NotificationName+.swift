//
//  NotificationName+.swift
//  Presentation
//
//  Created by nakandakari on 2020/10/10.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

// MARK: - Show, Hide Setting Navigation Item
extension Notification.Name {

    struct Setting {

        private static let Key = "Settings."

        static var show: NSNotification.Name { return NSNotification.Name("\(Key)\(#function)") }
        static var hide: NSNotification.Name { return NSNotification.Name("\(Key)\(#function)") }
    }

    struct Refresh {

        private static let Key = "Refresh."

        static var show: NSNotification.Name { return NSNotification.Name("\(Key)\(#function)") }
        static var hide: NSNotification.Name { return NSNotification.Name("\(Key)\(#function)") }

    }
}
