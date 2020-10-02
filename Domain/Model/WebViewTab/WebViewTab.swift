//
//  WebViewTab.swift
//  Domain
//
//  Created by nakandakari on 2020/10/02.
//  Copyright © 2020 nakandakari. All rights reserved.
//

public enum WebViewTab: Int, CaseIterable {
    case classicChallenge
    case grandChallenge
    case topLadder

    public var label: String {
        switch self {
        case .classicChallenge: return "Classic"
        case .grandChallenge:   return "Grand"
        case .topLadder:        return "TopLadder"
        }
    }
}
