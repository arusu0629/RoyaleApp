//
//  DeckCreateEvent.swift
//  Analytics
//
//  Created by nakandakari on 2020/09/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Domain
import Foundation

public enum DeckCreateEvent {
    case display
    case selectClear
    case selectCardSort(cardSortType: CardSortType)
    case selectDeckSelect(deck: DeckModel)
}

extension DeckCreateEvent: AnalyticsEvent {

    public var name: String {
        switch self {
        case .display:
            return "deckcreate_display"
        case .selectClear:
            return "deckcreate_select_clear"
        case .selectCardSort:
            return "deckcreate_select_card_sort"
        case .selectDeckSelect:
            return "deckcreate_select_deck_select"
        }
    }

    public var properties: [AnyHashable : Any] {
        switch self {
        case .display, .selectClear:
            return [:]
        case.selectCardSort(let cardSortType):
            return [AnalyticsManager.EventProperty.cardSortType.key: cardSortType.label]
        case .selectDeckSelect(let deck):
            let cardIds = deck.cards.map { String($0.id) }.joined(separator: ",")
            return [AnalyticsManager.EventProperty.deckCardIds.key: cardIds]
        }
    }
}

private extension CardSortType {

    var label: String {
        switch self {
        case .arena:
            return "arena"
        case .elixir:
            return "elixir"
        case .rarity:
            return "rarity"
        case .rarityDescending:
            return "rarity(desc)"
        case .level:
            return "level"
        }
    }
}
