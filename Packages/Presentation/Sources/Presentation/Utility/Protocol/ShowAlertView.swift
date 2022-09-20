//
//  ShowAlertView.swift
//  Presentation
//
//  Created by nakandakari on 2020/06/08.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

protocol ShowAlertView: AnyObject {

    func showAlert(_ title: String,
                   message: String,
                   actions: [UIAlertAction])
}

extension ShowAlertView where Self: UIViewController {

    func showAlert(_ title: String,
                   message: String,
                   actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        self.present(alert, animated: true, completion: nil)
    }
}
