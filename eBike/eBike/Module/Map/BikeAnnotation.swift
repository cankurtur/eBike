//
//  BikeAnnotation.swift
//  eBike
//
//  Created by Can Kurtur on 22.04.2023.
//

import Foundation
import MapKit

class BikeAnnotation: NSObject, Encodable, Decodable, MKAnnotation {
    let id: String
    let name: String
    let color: String
    let pin: String
    let location: LocationModel
    let rented: Bool
    
    init(bikesResponseModel: BikesResponseModel) {
        self.id = bikesResponseModel.id ?? ""
        self.name = bikesResponseModel.name ?? ""
        self.color = bikesResponseModel.color ?? ""
        self.pin = bikesResponseModel.pin ?? ""
        self.location = LocationModel(locationResponseModel: bikesResponseModel.location)
        self.rented = bikesResponseModel.rented ?? false
    }
    
    var coordinate: CLLocationCoordinate2D {
        get {
            let location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            return location
        }
    }
}

class LocationModel: Encodable, Decodable {
    let latitude: Double
    let longitude: Double
    
    init(locationResponseModel: LocationResponseModel?) {
        self.latitude = locationResponseModel?.latitude ?? 0
        self.longitude = locationResponseModel?.longitude ?? 0
    }
}

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
