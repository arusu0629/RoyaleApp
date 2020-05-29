//
//  CRPlayerAPIRequest.swift
//  DataStore
//
//  Created by nakandakari on 2020/05/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

struct CRPlayerAPIRequest: CRAPIRequestable {
    
    let path: String
    
    init(tag: String) {
        self.path = "players/\(tag)"
    }
}
