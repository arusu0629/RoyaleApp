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

    // TODO: 埋め込みしない
    var token: String {
        return "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjU1YzNiN2JmLTY5YjAtNGU4OC04YjBiLTA3N2ExZWMwODI2YiIsImlhdCI6MTU5MDU0OTU4MSwic3ViIjoiZGV2ZWxvcGVyLzU4Yjg4ZTlhLTViMDEtZTI5YS03N2M4LWFjNWY1NWI3MTJmOSIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbeyJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRycyI6WyIxMjguMTI4LjEyOC4xMjgiXSwidHlwZSI6ImNsaWVudCJ9XX0.6rxr4aWqE2m7TiiWssl0WF80WUfCrkmhlpfXLm2rwYE0mwWxiD93KkxtnhnjdaK872nvvCFOLNbyavmxPWHlmg"
    }

    var headers: HTTPHeaders {
        return
            [
                "Authorization": "Bearer " + self.token
        ]
    }
}
