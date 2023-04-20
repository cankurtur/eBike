//
//  AlertManager.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import UIKit

final class AlertManager {
    
    static let shared: AlertManager = AlertManager()
    
    private init() { }
    
    func showAlertFromTopViewController(
        message: String,
        title: String,
        firstButtonTitle: String = L10n.General.ok,
        firstButtonAction: (() -> Void)? = nil) {
            
            let alertViewController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert)
            
            alertViewController.addAction(UIAlertAction(
                title: firstButtonTitle,
                style: .default,
                handler: { _ in
                    if let action = firstButtonAction {
                        action()
                    }
                }))
            
            UIApplication.topMostViewController()?.present(alertViewController, animated: true)
        }
    
    func showAlertFromTopViewController(
        message: String,
        title: String,
        firstButtonTitle: String,
        firstButtonAction: (() -> Void)? = nil,
        secondButtonTitle: String,
        secondButtonAction: (() -> Void)? = nil) {
            
            let alertViewController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert)
            
            alertViewController.addAction(UIAlertAction(
                title: firstButtonTitle,
                style: .default,
                handler: { _ in
                    if let action = firstButtonAction {
                        action()
                    }
                }))
            
            alertViewController.addAction(UIAlertAction(
                title: secondButtonTitle,
                style: .default,
                handler: { _ in
                    if let action = secondButtonAction {
                        action()
                    }
                }))
            
            UIApplication.topMostViewController()?.present(alertViewController, animated: true)
        }
    
    func showAlert(
        message: String,
        title: String,
        view: UIViewController,
        action: (() -> Void)?) {
            
            let alertViewController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert)
            
            alertViewController.addAction(UIAlertAction(
                title: L10n.General.ok,
                style: .default,
                handler: { _ in
                    if let action = action {
                        action()
                    }
                }))
            
            view.present(alertViewController, animated: true)
        }
    
    func showAlert(
        message: String,
        title: String,
        firstButtonTitle: String,
        firstButtonAction: (() -> Void)? = nil,
        secondButtonTitle: String,
        secondButtonAction: (() -> Void)? = nil,
        view: UIViewController) {
            
            let alertViewController = UIAlertController(
                title: title,
                message: message,
                preferredStyle: UIAlertController.Style.alert)
            
            alertViewController.addAction(UIAlertAction(
                title: firstButtonTitle,
                style: .default,
                handler: { _ in
                    if let action = firstButtonAction {
                        action()
                    }
                }))
            
            alertViewController.addAction(UIAlertAction(
                title: secondButtonTitle,
                style: .default,
                handler: { _ in
                    if let action = secondButtonAction {
                        action()
                    }
                }))
            
            view.present(alertViewController, animated: true)
        }
}

