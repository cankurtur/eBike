//
//  UserDefaultsExtension.swift
//  eBike
//
//  Created by Can Kurtur on 24.04.2023.
//

import Foundation

extension UserDefaults {
    
    /// When a new property is added for UserDefaults, this enum should be written as a case.
    enum Key: String, CaseIterable {
        case currentBike
        case isOnTrip
    }
    
    func reset() {
        Key.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}
