//
//  AppLanguageUseCase.swift
//  Domain
//
//  Created by nakandakari on 2021/09/14.
//

import DataStore
import Foundation

public enum AppLanguageUseCaseProvider {
    public static func provide() -> AppLanguageUseCase {
        return AppLanguageUseCaseImpl(repository: UserDefaultsRepositoryProvider.provide())
    }
}

public protocol AppLanguageUseCase {
    func set(language: AppLanguage)
    func get() -> AppLanguage
    func all() -> [AppLanguage]
}

public final class AppLanguageUseCaseImpl: AppLanguageUseCase {

    private let repository: UserDefaultsRepository

    init(repository: UserDefaultsRepository) {
        self.repository = repository
    }

    public func set(language: AppLanguage) {
        self.repository.set(value: language.rawValue, type: .appLanguage)
    }

    public func get() -> AppLanguage {
        guard let appLanguageIndex: Int = self.repository.get(type: .appLanguage),
              let appLanguage = AppLanguage(rawValue: appLanguageIndex) else {
            return AppLanguage.defaultLanguage
        }
        return appLanguage
    }

    public func all() -> [AppLanguage] {
        return AppLanguage.allCases
    }
}
