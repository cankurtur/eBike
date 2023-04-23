//
//  SwiftMessagesManager.swift
//  eBike
//
//  Created by Can Kurtur on 22.04.2023.
//

import SwiftMessages

final class SwiftMessagesManager {
    
    static let shared = SwiftMessagesManager()
    
    private init() {}
    
    func showForever(view: UIView, dimColor: UIColor? = Colors.appGray.color.withAlphaComponent(0.8), presentationStyle: SwiftMessages.PresentationStyle = .center, interactive: Bool = false) {
        var config = SwiftMessages.defaultConfig
        config.duration = .forever
        if let dimColor = dimColor {
            config.dimMode = .color(color: dimColor, interactive: interactive)
        }
        config.presentationStyle = presentationStyle
        SwiftMessages.show(config: config, view: view)
    }
    
    func hide() {
        SwiftMessages.hide()
    }
}
