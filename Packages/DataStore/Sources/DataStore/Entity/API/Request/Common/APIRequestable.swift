//
//  APIRequestable.swift
//  DataStore
//
//  Created by nakandakari on 2020/05/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Alamofire
import Foundation

protocol APIRequestable: Encodable {
    var urlString: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
    var headers: HTTPHeaders { get }
}

extension APIRequestable {

    var parameters: [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder.encodeToDictionary(self)
    }
}

private extension JSONEncoder {

    // Encodable 構造体から Data に変換し後に Dictionary にする (APIのパラメータ生成用)
    func encodeToDictionary<T: Encodable>(_ value: T) -> [String: Any] {
        do {
            let data = try self.encode(value)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return (jsonObject as? [String: Any]) ?? [:]
        } catch {
            print(error.localizedDescription)
            return [:]
        }
    }
}
