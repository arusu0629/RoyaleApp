//
//  WebViewError.swift
//  Domain
//
//  Created by nakandakari on 2020/10/02.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum WebViewError: Error {
    case invalidURL(url: String)
}
