//
//  ViewInterface.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import UIKit

public protocol ViewInterface: AnyObject {
    func showPopup(title: String, message: String)
    func showPopup(title: String, message: String, buttonTitle: String)
    func showPopup(title: String, message: String, buttonTitle: String, buttonAction: (() -> Void)?)
    func showPopup(error: APIClientError, buttonAction: (() -> Void)?)
}

public extension ViewInterface where Self: UIViewController {
    func showPopup(title: String, message: String) {
        SwiftMessagesManager.shared.showForever(with: .defaultPopup(title: title,
                                                                    message: message,
                                                                    buttonTitle: L10n.AppPopupView.ok,
                                                                    action: nil))
    }
    
    func showPopup(title: String, message: String, buttonTitle: String) {
        SwiftMessagesManager.shared.showForever(with: .defaultPopup(title: title,
                                                                    message: message,
                                                                    buttonTitle: buttonTitle,
                                                                    action: nil))
    }
    
    func showPopup(title: String, message: String, buttonTitle: String, buttonAction: (() -> Void)?) {
        SwiftMessagesManager.shared.showForever(with: .defaultPopup(title: title,
                                                                    message: message,
                                                                    buttonTitle: buttonTitle,
                                                                    action: buttonAction))
    }
    
    func showPopup(error: APIClientError, buttonAction: (() -> Void)?) {
        SwiftMessagesManager.shared.showForever(with: .networkErrorPopup(message: error.message,
                                                                         action: buttonAction))
    }
}
