//
//  PlayerModel.swift
//  Domain
//
//  Created by nakandakari on 2020/06/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation

enum PlayerModelError: LocalizedError {
    case invalid

    var errorDescription: String? {
        switch self {
        case .invalid:
            return "Invalid player tag"
        }
    }
}

public struct PlayerModel {

    public let tag: String?
}

extension PlayerModel {

    init(_ response: CRPlayerResponse) {
        self.tag = response.tag
    }
}
