//
//  DateFormatter+.swift
//  Presentation
//
//  Created by nakandakari on 2020/06/28.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

extension DateFormatter {

    enum Template: String {
        case date = "MMdd" // 1/1
    }

    func setTemplate(_ template: Template) {
        dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: .current)
    }
}
