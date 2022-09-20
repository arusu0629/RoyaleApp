//
//  DeckEvent.swift
//  Analytics
//
//  Created by nakandakari on 2020/09/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import Foundation

public enum DeckEvent {
    case display
    case selectCreateDeck
    case selectChangeDeck
    case selectShareDeck(deck: DeckModel)
}

extension DeckEvent: AnalyticsEvent {

    public var name: String {
        switch self {
        case .display:
            return "deck_display"
        case .selectCreateDeck:
            return "deck_select_create_deck"
        case .selectChangeDeck:
            return "deck_select_change_deck"
        case .selectShareDeck:
            return "deck_select_share_deck"
        }
    }

    public var properties: [AnyHashable : Any] {
        switch self {
        case .display, .selectCreateDeck, .selectChangeDeck:
            return [:]
        case .selectShareDeck(let deck):
            let cardIds = deck.cards.map { String($0.id) }.joined(separator: ",")
            return [AnalyticsManager.EventProperty.deckCardIds.key: cardIds]
        }
    }
}
