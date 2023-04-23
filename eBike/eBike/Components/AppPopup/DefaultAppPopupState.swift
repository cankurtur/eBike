//
//  DefaultAppPopupState.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import Foundation

enum DefaultAppPopupState {
    case registerBikeSuccess
    case registerBikeNameError
    case registerBikePinError
    case registerBikeColorError
    
    var model: AppPopupViewModel {
        switch self {
        case .registerBikeSuccess:
            return AppPopupViewModel(title: L10n.AppPopupView.success,
                                     description: L10n.AppPopupView.youHaveRegister,
                                     buttonTitle: L10n.AppPopupView.cool) {
                SwiftMessagesManager.shared.hide()
            }
        case .registerBikeNameError:
            return AppPopupViewModel(title: L10n.AppPopupView.error,
                                     description: L10n.AppPopupView.nameErrorMessage,
                                     buttonTitle: L10n.AppPopupView.ok) {
                SwiftMessagesManager.shared.hide()
            }
        case .registerBikePinError:
            return AppPopupViewModel(title: L10n.AppPopupView.error,
                                     description: L10n.AppPopupView.pinErrorMessage,
                                     buttonTitle: L10n.AppPopupView.ok) {
                SwiftMessagesManager.shared.hide()
            }
        case .registerBikeColorError:
            return AppPopupViewModel(title: L10n.AppPopupView.error,
                                     description: L10n.AppPopupView.colorErrorMessage,
                                     buttonTitle: L10n.AppPopupView.ok) {
                SwiftMessagesManager.shared.hide()
            }
        }
    }
}
