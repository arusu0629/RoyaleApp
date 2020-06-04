//
//  CRChestsAPIRequest.swift
//  DataStore
//
//  Created by nakandakari on 2020/06/04.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

struct CRUpComingChestsAPIRequest: CRAPIRequestable {

    let path: String

    init(tag: String) {
        self.path = "players/\(tag)/upcomingchests"
    }
}
