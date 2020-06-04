//
//  ChestsTranslator.swift
//  Domain
//
//  Created by nakandakari on 2020/06/04.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation

protocol UpComingChestsTranslator {
    func convert(from response: CRUpComingChestsResponse) -> UpComingChestsModel
}

private struct UpComingChestsTranslatorImpl: UpComingChestsTranslator {

    func convert(from response: CRUpComingChestsResponse) -> UpComingChestsModel {
        return UpComingChestsModel(response)
    }
}
