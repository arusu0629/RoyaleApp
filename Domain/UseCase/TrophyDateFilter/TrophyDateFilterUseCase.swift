//
//  TrophyDateFilter.swift
//  Domain
//
//  Created by nakandakari on 2020/07/17.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum TrophyDateFilterUseCaseProvider {

    public static func provide() -> TrophyDateFilterUseCase {
        return TrophyDateFilterUseCaseImpl()
    }
}

public protocol TrophyDateFilterUseCase {
    func list() -> [TrophyDateFilter]
}

private struct TrophyDateFilterUseCaseImpl: TrophyDateFilterUseCase {

    func list() -> [TrophyDateFilter] {
        return TrophyDateFilter.allCases
    }
}
