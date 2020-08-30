//
//  DeckModel.swift
//  Domain
//
//  Created by nakandakari on 2020/08/31.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation
import RealmSwift

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

public final class RealmDeckModel: Object {
    @objc dynamic public var index: Int = 0
    @objc dynamic public var playerTag: String = ""
    @objc dynamic public var name: String = ""
    public var cardIds = List<Int>()

    public override class func primaryKey() -> String? {
        return "index"
    }
}

extension RealmDeckModel {

    public static func create(playerTag: String, index: Int, name: String, deckModel: DeckModel) -> RealmDeckModel {
        let realmDeckModel = RealmDeckModel()
        realmDeckModel.index = index
        realmDeckModel.playerTag = playerTag
        realmDeckModel.name = name
        realmDeckModel.cardIds.append(objectsIn: deckModel.cards.map { $0.id })
        return realmDeckModel
    }

    public func convertToDeckModel(cards: [CardModel]) -> DeckModel {
        var deckModel = DeckModel()

        self.cardIds.forEach { cardId in
            if let cardIndex = cards.firstIndex(where: { $0.id == cardId }) {
                deckModel.cards.append(cards[cardIndex])
            }
        }

        return deckModel
    }
}

public struct DeckModel {
    public var cards: [CardModel] = []

    public init(cards: [CardModel] = []) {
        self.cards = cards
    }
}
