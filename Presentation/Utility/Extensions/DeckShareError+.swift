//
//  DeckShareError+.swift
//  Presentation
//
//  Created by nakandakari on 2021/09/17.
//

import Domain
import Foundation

extension DeckShareError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidCardCount:
            return "error_deck_share_invalid_card_count_title_key".localized
        case .duplication:
            return "error_deck_share_duplication_title_key".localized
        case .invalidURL:
            return "error_deck_share_invalid_url_title_key".localized
        }
    }
}
