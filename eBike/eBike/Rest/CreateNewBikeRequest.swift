//
//  CreateNewBikeRequest.swift
//  eBike
//
//  Created by Can Kurtur on 22.04.2023.
//

import Foundation

struct CreateNewBikeRequest: Codable {
    let name: String
    let pin: String
    let color: String
    let location: Location
}

struct Location: Codable {
    let latitude: Double
    let longitude: Double
}
