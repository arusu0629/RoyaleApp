//
//  DeckShareError.swift
//  Domain
//
//  Created by nakandakari on 2020/10/02.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum DeckShareError: LocalizedError {
    case invalidCardCount
    case duplication
    case invalidURL

    public var errorDescription: String? {
        switch self {
        case .invalidCardCount:
            return "You need 8 cards for a deck share"
        case .duplication:
            return "All 8 cards must be different cards"
        case .invalidURL:
            return "Invalid URL\nPlease try again later"
        }
    }
}
