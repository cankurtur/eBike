//
//  HUDManager.swift
//  eBike
//
//  Created by Can Kurtur on 25.04.2023.
//

import MBProgressHUD

// MARK: - HUDManager

final class HUDManager {
    
    static let shared: HUDManager = HUDManager()
    
    private init() {}
    
    func showHUD(text: String, onMainThread: Bool = false, viewController: UIViewController) {
        if onMainThread {
            let progressHUD = MBProgressHUD.showAdded(to: viewController.view, animated: true)
            progressHUD.mode = .indeterminate
            progressHUD.label.text = text
            progressHUD.label.font = UIFont.systemFont(ofSize: 14)
        } else {
            DispatchQueue.main.async {
                let progressHUD = MBProgressHUD.showAdded(to: viewController.view, animated: true)
                progressHUD.mode = .indeterminate
                progressHUD.label.text = text
                progressHUD.label.font = UIFont.systemFont(ofSize: 14)
            }
        }
    }

    func dismissHUD(isAnimated: Bool = true, viewController: UIViewController) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: viewController.view, animated: isAnimated)
        }
    }
}
