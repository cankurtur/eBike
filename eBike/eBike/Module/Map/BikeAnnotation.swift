//
//  BikeAnnotation.swift
//  eBike
//
//  Created by Can Kurtur on 22.04.2023.
//

import Foundation
import MapKit

// MARK: - BikeAnnotationModel

final class BikeAnnotation: NSObject, Codable, MKAnnotation {
    let id: String
    let name: String
    let hexColor: String
    let pin: String
    let location: LocationModel
    let rented: Bool
    
    init(from bikesResponseModel: BikesResponseModel) {
        self.id = bikesResponseModel.id ?? ""
        self.name = bikesResponseModel.name ?? ""
        self.hexColor = bikesResponseModel.color ?? ""
        self.pin = bikesResponseModel.pin ?? ""
        self.location = LocationModel(from: bikesResponseModel.location)
        self.rented = bikesResponseModel.rented ?? false
    }
    
    var coordinate: CLLocationCoordinate2D {
        get {
            let location = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            return location
        }
    }
}

// MARK: - LocationModel

final class LocationModel: Codable {
    let latitude: Double
    let longitude: Double
    
    init(from locationResponseModel: LocationResponseModel?) {
        self.latitude = locationResponseModel?.latitude ?? 0
        self.longitude = locationResponseModel?.longitude ?? 0
    }
}
