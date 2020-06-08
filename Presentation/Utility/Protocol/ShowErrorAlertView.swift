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
        self.showAlert("Error", message: error.localizedDescription, actions: [
            .init(title: "Close", style: .default, handler: nil)
        ])
    }
}
