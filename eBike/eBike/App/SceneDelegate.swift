//
//  SceneDelegate.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return 
        }
        
        window = UIWindow(windowScene: windowScene)
        let navCon = MainRouter.createModule()
        window?.rootViewController = navCon
        window?.makeKeyAndVisible()
        
    }
}

