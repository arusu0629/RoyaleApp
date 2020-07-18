//
//  SceneDelegate.swift
//  RoyaleApp
//
//  Created by nakandakari on 2020/05/26.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Presentation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else {
            return
        }
        self.setupWindow(scene)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        BackgroundTaskManager.shared.scheduleAppRefresh()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        guard let homeViewController = self.homeViewController() else {
            return
        }
        homeViewController.willEnterForground()
    }
}

// MARK: - Setup Window
extension SceneDelegate {

    private func setupWindow(_ scene: UIWindowScene) {
        self.window = UIWindow(windowScene: scene)
        let navigationController = UINavigationController(rootViewController: RootBuilder.build())
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        self.window?.overrideUserInterfaceStyle = .dark
    }
}

// MARK: - HomeViewController
extension SceneDelegate {

    private func homeViewController() -> HomeViewController? {

        guard let navigationController = self.window?.rootViewController as? UINavigationController,
            let rootViewController = navigationController.viewControllers[0] as? RootViewController else {
                return nil
        }

        guard let viewControllers = rootViewController.viewControllers,
            let homeViewController = viewControllers[0] as? HomeViewController else {
                return nil
        }

        return homeViewController
    }
}
