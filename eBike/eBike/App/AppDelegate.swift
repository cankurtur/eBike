//
//  AppDelegate.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupInternetMonitoring()
        return true
    }

    private func setupInternetMonitoring() {
        MonitorManager.shared.startMonitoring()
    }
}

