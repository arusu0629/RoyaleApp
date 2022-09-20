//
//  PlayerTranslator.swift
//  Domain
//
//  Created by nakandakari on 2020/06/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation

enum PlayerTranslatorProvider {
    static func provide() -> PlayerTranslator {
        return PlayerTranslatorImpl()
    }
}

protocol PlayerTranslator {
    func convert(from response: CRPlayerResponse) -> PlayerModel
}

private struct PlayerTranslatorImpl: PlayerTranslator {

    func convert(from response: CRPlayerResponse) -> PlayerModel {
        return PlayerModel(response)
    }
}
