//
//  ChestsModel.swift
//  Domain
//
//  Created by nakandakari on 2020/06/04.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation

public struct UpComingChestsModel {

    public let chests: [UpComingChest]?
}

extension UpComingChestsModel {

    init(_ response: CRUpComingChestsResponse) {
        guard let items = response.items else {
            self.chests = []
            return
        }
        self.chests = items.map { UpComingChest($0) }
    }
}

// MARK: - Chest
extension UpComingChestsModel {

    public enum ChestType {
        case silver
        case golden
        case giant
        case magical
        case epic
        case legendary
        case megaLightning
        case none
    }

    public struct UpComingChest {

        public let index: Int
        public var type: ChestType = .none
    }
}

extension UpComingChestsModel.UpComingChest {

    init(_ chest: CRUpComingChestsResponse.Item) {
        self.index = chest.index ?? 0
        self.type = self.nameToType(chest.name)
    }
}

extension UpComingChestsModel.UpComingChest {

    private func nameToType(_ name: String?) -> UpComingChestsModel.ChestType {
        guard let name = name else {
            return .none
        }
        switch name {
        case "Silver Chest":
            return .silver
        case "Golden Chest":
            return .golden
        case "Giant Chest":
            return .giant
        case "Magical Chest":
            return .magical
        case "Epic Chest":
            return .epic
        case "Legendary Chest":
            return .legendary
        case "Mega Lightning Chest":
            return .megaLightning
        default:
            return .none
        }
    }
}
