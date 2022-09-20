//
//  PlayerModelError.swift
//  Domain
//
//  Created by nakandakari on 2020/10/02.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum PlayerModelError: LocalizedError {
    case invalidPlayerTag(tag: String)

    public var errorDescription: String? {
        switch self {
        case .invalidPlayerTag(let tag):
            return "Invalid player tag = \(tag)"
        }
    }
}
