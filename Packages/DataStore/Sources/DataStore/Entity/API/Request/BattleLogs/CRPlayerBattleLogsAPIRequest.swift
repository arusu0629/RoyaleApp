//
//  CRBattleLogsAPIRequest.swift
//  DataStore
//
//  Created by nakandakari on 2020/06/25.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

struct CRPlayerBattleLogsAPIRequest: CRAPIRequestable {

    let path: String

    init(tag: String) {
        self.path = "players/\(tag)/battlelog"
    }
}
