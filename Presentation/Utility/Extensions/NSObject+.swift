//
//  NSObject+.swift
//  Presentation
//
//  Created by nakandakari on 2020/06/04.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

// クラス名を取得する。
// Objective-CのNSStringFromClassに相当する
extension NSObject {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}
