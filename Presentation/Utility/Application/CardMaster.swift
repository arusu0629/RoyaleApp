//
//  CardMaster.swift
//  Presentation
//
//  Created by nakandakari on 2020/07/27.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation
import UIKit

public final class CardMaster {

    public static let shared = CardMaster()
    let cards: [Card] = Utility.load("Cards.json")

    private init() {}

    public func getCard(id: Int) -> Card? {
        return cards.first { $0.id == id }
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
