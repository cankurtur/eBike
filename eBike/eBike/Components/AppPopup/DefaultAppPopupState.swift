//
//  DefaultAppPopupState.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import Foundation

// MARK: - DefaultAppPopupState

public enum DefaultAppPopupState {
    case defaultPopup(title: String,
                      message: String,
                      buttonTitle: String,
                      action: (() -> Void)?)
    case networkErrorPopup(message: String, action: (() -> Void)?)
    
    var model: AppPopupViewModel {
        switch self {
        case .defaultPopup(let title, let message, let buttonTitle, let action):
            return AppPopupViewModel(title: title,
                                     description: message,
                                     buttonTitle: buttonTitle) {
                SwiftMessagesManager.shared.hide()
                action?()
            }
        case .networkErrorPopup(let message, let action):
            return AppPopupViewModel(title: L10n.AppPopupView.error,
                                     description: message,
                                     buttonTitle: L10n.AppPopupView.ok) {
                SwiftMessagesManager.shared.hide()
                action?()
            }
        }
    }
}
