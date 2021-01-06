//
//  CardMaster.swift
//  Presentation
//
//  Created by nakandakari on 2020/07/27.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import Foundation
import UIKit

public final class DeckMaster {

    public static let shared = DeckMaster()

    public func createDeckShareUrl(currentDeck: DeckModel) -> URL? {
        var urlString = "https://link.clashroyale.com/deck/jp?"
        var deckParameter = "deck="
        let deckParamSeparator = ";"
        for (index, card) in currentDeck.cards.enumerated() {
            deckParameter += String(card.id)
            if index == currentDeck.cards.count - 1 {
                deckParameter += "&"
            } else {
                deckParameter += deckParamSeparator
            }
        }

        var playerTagParamter = "id="
        playerTagParamter += AppConfig.playerTag

        urlString += deckParameter + playerTagParamter
        return URL(string: urlString)
    }
}

public final class CardMaster {

    public static let shared = CardMaster()
    let cards: [Card] = Utility.load("Cards.json")

    private init() {}

    public func getCard(id: Int) -> Card? {
        return cards.first { $0.id == id }
    }

    public func getElixir(id: Int) -> Int {
        return getCard(id: id)?.elixir ?? 1
    }

    public func getArena(id: Int) -> Int {
        return getCard(id: id)?.arena ?? 1
    }

    public func getRarity(id: Int) -> CardRarity {
        return CardRarity(rarity: getCard(id: id)?.rarity)
    }

    public func convertCardLevel(id: Int, playerCardLevel: Int) -> Int {
        let card = self.getCard(id: id)
        let rarity = CardRarity(rarity: card?.rarity ?? "")
        return playerCardLevel + rarity.cardLevelOffset
    }
}

public struct Card: Codable {
    public let key: String
    public let name: String
    public let sc_key: String
    public let elixir: Int
    public let type: String
    public let rarity: String
    public let arena: Int
    public let description: String
    public let id: Int
}

public enum CardRarity: Int {
    case normal = 0
    case rare
    case epic
    case legendary
    case none

    var cardLevelOffset: Int {
        switch self {
        case .normal, .none:
            return 0
        case .rare:
            return 2
        case .epic:
            return 5
        case .legendary:
            return 8
        }
    }

    init(rarity: String?) {
        guard let rarity = rarity else {
            self = .none
            return
        }
        self.init(rarity: rarity)
    }

    init(rarity: String) {
        switch rarity {
        case "Common":
            self = .normal
        case "Rare":
            self = .rare
        case "Epic":
            self = .epic
        case "Legendary":
            self = .legendary
        default:
            self = .none
        }
    }
}
