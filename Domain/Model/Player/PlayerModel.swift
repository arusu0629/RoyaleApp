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

    public let name: String
    public let tag: String
    public let clanName: String
    public let trophy: Int

}

extension PlayerModel {

    init(_ response: CRPlayerResponse) {
        self.name = response.name ?? ""
        self.tag = response.tag ?? ""
        self.clanName = response.clan?.name ?? ""
        self.trophy = response.trophies ?? 0
    }
}

extension PlayerModel {

    public func isEmptyTag() -> Bool {
        return self.tag.isEmpty
    }
}
