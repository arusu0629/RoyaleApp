//
//  LoadingManager.swift
//  Presentation
//
//  Created by nakandakari on 2020/10/18.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit
import Foundation

final class LoadingManager {

    static let shared: LoadingManager = LoadingManager()
    private init() {}
}

// MARK: - CancelableLoadingView
extension LoadingManager {

    func createCancelableLoadingView(title: String) -> CancelableLoadingView {
        let view = CancelableLoadingView(frame: UIScreen.main.bounds)
        view.setTitle(title)
        return view
    }
}
