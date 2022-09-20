//
//  CRAPIRequestable.swift
//  DataStore
//
//  Created by nakandakari on 2020/05/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Alamofire
import Foundation

// クラッシュロワイヤル用の API Requestable
protocol CRAPIRequestable: APIRequestable {

    var path: String { get }
    var token: String { get }
}

extension CRAPIRequestable {

    var urlString: String {
        return "https://proxy.royaleapi.dev/v1/\(self.path)"
    }

    var method: HTTPMethod {
        return .get
    }

    var token: String {
        return DataStoreConfig.token
    }

    var headers: HTTPHeaders {
        return
            [
                "Authorization": "Bearer " + self.token
            ]
    }
}
