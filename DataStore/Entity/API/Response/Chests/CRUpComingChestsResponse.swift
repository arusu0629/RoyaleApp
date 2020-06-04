//
//    CRChestsResponse.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct CRUpComingChestsResponse: Decodable {

    public let items : [Item]?
}

extension CRUpComingChestsResponse {

    public struct Item: Decodable {

        public let index: Int?
        public let name: String?
    }
}
