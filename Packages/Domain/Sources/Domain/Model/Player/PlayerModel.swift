//
//  PlayerModel.swift
//  Domain
//
//  Created by nakandakari on 2020/06/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation

public struct PlayerModel {

    public let name: String
    public let tag: String
    public let clanName: String
    public var cards: [CardModel]
    public var trophies: Int
}

extension PlayerModel {

    init(_ response: CRPlayerResponse) {
        self.name = response.name ?? ""
        self.tag = response.tag ?? ""
        self.clanName = response.clan?.name ?? ""
        self.trophies = response.trophies ?? 0

        if let cards = response.cards {
            self.cards = cards.map { CardModel($0) }
        } else {
            self.cards = []
        }
    }
}

extension PlayerModel {

    public func isEmptyTag() -> Bool {
        return self.tag.isEmpty
    }
}
