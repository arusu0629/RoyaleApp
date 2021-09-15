//
//  String+.swift
//  Presentation
//
//  Created by nakandakari on 2021/09/15.
//

import Domain
import Foundation

extension String {

    var localized: String {
        let lang = AppLanguageUseCaseProvider.provide().get().lang
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(self, comment: "")
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}

private extension AppLanguage {

    var lang: String {
        switch self {
        case .en : return "en"
        case .ja : return "ja"
        }
    }
}
