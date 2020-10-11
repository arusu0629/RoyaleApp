//
//  DeckCreateError.swift
//  Domain
//
//  Created by nakandakari on 2020/10/11.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum DeckCreateError: LocalizedError {
    case limitedCreate(canCreateCount: Int)

    public var errorDescription: String? {
        switch self {
        case .limitedCreate(let canCreateCount):
            return "You can only create up \(canCreateCount) decks."
        }
    }
}
