//
//  AppPopupViewModel.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import Foundation

// MARK: - AppPopupViewModel

struct AppPopupViewModel {
    let title: String
    let description: String
    let buttonTitle: String
    let buttonAction: (() -> Void)?
}
