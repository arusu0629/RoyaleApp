//
//  TabUseCase.swift
//  Domain
//
//  Created by nakandakari on 2020/05/29.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum TabUseCaseProvider {

    public static func provide() -> TabUseCase {
        return TabUseCaseImpl()
    }
}

public protocol TabUseCase {
    func list() -> [Tab]
}

private struct TabUseCaseImpl: TabUseCase {

    func list() -> [Tab] {
        return Tab.allCases
    }
}
