//
//  CardModel.swift
//  Domain
//
//  Created by nakandakari on 2020/08/31.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation

public struct CardModel {

    public let id: Int
    public let level: Int
    public let iconUrl: String

    init(_ card: CRPlayerResponse.Card) {
        self.id = card.id ?? 0
        self.level = card.level ?? 1
        self.iconUrl = card.iconUrls?.medium ?? ""
    }
}
