//
//  SceneDelegate.swift
//  RoyaleApp
//
//  Created by nakandakari on 2020/05/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Presentation
import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        self.setupWindow(scene)
    }
}

// MARK: - Setup Window
@available(iOS 13.0, *)
extension SceneDelegate {
    
    private func setupWindow(_ scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController(rootViewController: RootBuilder.build())
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
