//
//  DeckShareError.swift
//  Domain
//
//  Created by nakandakari on 2020/10/02.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum DeckShareError: Error {
    case invalidCardCount
    case duplication
    case invalidURL
}
