//
//  RealmDataStoreError.swift
//  DataStore
//
//  Created by nakandakari on 2020/10/06.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum RealmDataStoreError: LocalizedError {
    case instance
    case failedDelete

    public var errorDescription: String? {
        switch self {
        case .instance:
            return "Unknown error"
        case .failedDelete:
            return "Failed to delete data"
        }
    }
}
