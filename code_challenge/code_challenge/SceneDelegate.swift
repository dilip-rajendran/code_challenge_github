//
//  SceneDelegate.swift
//  code_challenge
//
//  Created by Dilip on 4/5/20.
//  Copyright © 2020 Dilip. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let landing = SearchGitHubViewController()
        let navController = UINavigationController(rootViewController: landing)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        UILabel.appearance().defaultFont = UIFont(name: "Georgia", size: 18)
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

