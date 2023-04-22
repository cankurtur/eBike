//
//  UpdateBikeRequest.swift
//  eBike
//
//  Created by Can Kurtur on 22.04.2023.
//

import Foundation

struct UpdateBikeInfo {
    let id: Int
    let request: UpdateBikeRequest
}

struct UpdateBikeRequest: Codable {
    let name: String
    let color: String
    let pin: String
    let location: Location
}
