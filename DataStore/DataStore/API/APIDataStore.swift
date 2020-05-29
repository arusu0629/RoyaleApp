//
//  APIDataStore.swift
//  DataStore
//
//  Created by nakandakari on 2020/05/27.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Alamofire
import Foundation

enum APIDataStoreProvider {

    static func provide() -> APIDataStore {
        return APIDataStoreImpl(session: Session.default)
    }
}

protocol APIDataStore {
    typealias Completion = (Result<Data, Error>) -> Void

    func request(_ request: APIRequestable, complection: @escaping Completion)
}

private struct APIDataStoreImpl: APIDataStore {

    let session: Session

    func request(_ request: APIRequestable, complection: @escaping Completion) {
        // Alamofire を通じて実際に API を叩く処理
        self.session
            .request(request.urlString, method: request.method, parameters: request.parameters, headers: request.headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    complection(.success(data))
                case .failure(let error):
                    complection(.failure(error))
                }
        }
    }
}
