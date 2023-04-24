//
//  UserDefaultsConfig.swift
//  eBike
//
//  Created by Can Kurtur on 24.04.2023.
//


import Foundation

struct UserDefaultsConfig {
    
    @UserDefaultProperty(key: .currentBike, defaultValue: nil)
    static var currentBike: BikeAnnotation?
    
    @UserDefaultProperty(key: .isOnTrip, defaultValue: false)
    static var isOnTrip: Bool
}

