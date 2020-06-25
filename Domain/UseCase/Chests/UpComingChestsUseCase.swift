//
//  ChestsUsease.swift
//  Domain
//
//  Created by nakandakari on 2020/06/04.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import DataStore
import Foundation

enum UpComingChestsError: LocalizedError {
    case empty

    var errorDescription: String? {
        switch self {
        case .empty:
            return "Invalid player tag"
        }
    }
}

public enum UpComingChestsProvider {

    public static func provide() -> UpComingChestsUseCase {
        return UpComingChestsUseCaseImpl(
            repository: UpComingChestsRepositoryProvider.provide(),
            translator: UpComingChestsTranlatorProvider.provide()
        )
    }
}

public protocol UpComingChestsUseCase {
    typealias Completion = (Result<UpComingChestsModel, Error>) -> Void

    func get(playerTag: String, completion: @escaping Completion)
}

private struct UpComingChestsUseCaseImpl: UpComingChestsUseCase {

    let repository: UpComingChestsRepository
    let translator: UpComingChestsTranslator

    func get(playerTag: String, completion: @escaping (Result<UpComingChestsModel, Error>) -> Void) {
        self.repository.get(playerTag: playerTag) { result in
            switch result {
            case .success(let response):
                let chestsModel = self.translator.convert(from: response)
                if chestsModel.chests.isEmpty {
                    completion(.failure(UpComingChestsError.empty))
                    return
                }
                completion(.success(chestsModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
