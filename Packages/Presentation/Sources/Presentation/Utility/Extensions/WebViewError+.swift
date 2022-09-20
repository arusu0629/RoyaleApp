//
//  WebViewError+.swift
//  Presentation
//
//  Created by nakandakari on 2021/09/17.
//

import Domain
import Foundation

extension WebViewError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return String(format: "error_web_view_invalid_url_title_key".localized, url)
        }
    }
}
