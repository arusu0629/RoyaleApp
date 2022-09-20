//
//  ShowErrorAlertView.swift
//  Presentation
//
//  Created by nakandakari on 2020/06/08.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation

protocol ShowErrorAlertView: ShowAlertView {

    func showErrorAlert(_ error: Error)
}

extension ShowErrorAlertView {

    func showErrorAlert(_ error: Error) {
        let errorTitle = "error_alert_key".localized
        let closeTitle = "button_close_title_key".localized
        self.showAlert(errorTitle, message: error.localizedDescription, actions: [
            .init(title: closeTitle, style: .default, handler: nil)
        ])
    }
}
