//
//  BikesResponseModel.swift
//  eBike
//
//  Created by Can Kurtur on 22.04.2023.
//

import Foundation

struct BikesResponseModel: Codable {
    let id: String?
    let name: String?
    let color: String?
    let pin: String?
    let location: LocationResponseModel?
    let rented: Bool?
}

struct LocationResponseModel: Codable {
    let latitude: Double?
    let longitude: Double?
}
