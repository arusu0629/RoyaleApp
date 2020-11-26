//
//  Bundle+.swift
//  Presentation
//
//  Created by nakandakari on 2020/11/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

extension Bundle {

    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
}
