//
//  WebViewTabUseCase.swift
//  Domain
//
//  Created by nakandakari on 2020/10/02.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum WebViewTabUseCaseProvider {

    public static func provide() -> WebViewTabUseCase {
        return WebViewTabUseCaseImpl()
    }
}

public protocol WebViewTabUseCase {
    func list() -> [WebViewTab]
}

private struct WebViewTabUseCaseImpl: WebViewTabUseCase {

    func list() -> [WebViewTab] {
        return WebViewTab.allCases
    }
}
