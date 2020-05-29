//
//  CRAPIDataStore.swift
//  DataStore
//
//  Created by nakandakari on 2020/05/27.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

enum CRAPIDataStoreProvider {
    
    static func provide() -> CRAPIDataStore {
        return CRAPIDataStoreImpl(dataStore: APIDataStoreProvider.provide())
    }
}

protocol CRAPIDataStore {
    
    // RoyaleAPI 用の API 処理
    func request<T: Decodable>(_ request: CRAPIRequestable, completion: @escaping (Result<T, Error>) -> Void)
}

private struct CRAPIDataStoreImpl: CRAPIDataStore {
    
    let dataStore: APIDataStore
    
    func request<T>(_ request: CRAPIRequestable, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        self.dataStore.request(request) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let response = try decoder.decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
