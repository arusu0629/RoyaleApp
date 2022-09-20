//
//  SettingsSectionUseCase.swift
//  Domain
//
//  Created by nakandakari on 2020/10/02.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

public enum SettingsSelectionUseCaseProvider {
    public static func provide() -> SettingsSelectionUseCase {
        return SettingsSelectionUseCaseImpl()
    }
}

public protocol SettingsSelectionUseCase {
    func all() -> [SettingsSection]
}

public struct SettingsSelectionUseCaseImpl: SettingsSelectionUseCase {

    public func all() -> [SettingsSection] {
        return SettingsSection.allCases
    }
}
