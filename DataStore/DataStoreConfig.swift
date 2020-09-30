//
//  DataStoreConfig.swift
//  DataStore
//
//  Created by nakandakari on 2020/09/30.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public class DataStoreConfig {}

extension DataStoreConfig {

    public static var token: String {
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
        get {
            let defaultToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjU1YzNiN2JmLTY5YjAtNGU4OC04YjBiLTA3N2ExZWMwODI2YiIsImlhdCI6MTU5MDU0OTU4MSwic3ViIjoiZGV2ZWxvcGVyLzU4Yjg4ZTlhLTViMDEtZTI5YS03N2M4LWFjNWY1NWI3MTJmOSIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbeyJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRycyI6WyIxMjguMTI4LjEyOC4xMjgiXSwidHlwZSI6ImNsaWVudCJ9XX0.6rxr4aWqE2m7TiiWssl0WF80WUfCrkmhlpfXLm2rwYE0mwWxiD93KkxtnhnjdaK872nvvCFOLNbyavmxPWHlmg"
            return UserDefaults.standard.string(forKey: #function) ?? defaultToken
        }
    }
}
