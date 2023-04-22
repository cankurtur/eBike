//
//  BikesEndpointItem.swift
//  eBike
//
//  Created by Can Kurtur on 22.04.2023.
//

import Foundation

enum BikesEndpointItem: Endpoint {
    case allBikes
    case nearbyBikes(latitude: Double, longitude: Double, radius: Double)
    case createNewBike(request: CreateNewBikeRequest)
    case updateBike(info: UpdateBikeInfo)
    case rentBike(bikeId: Int)
    case returnBike(bikeId: Int)
    
    var path: String {
        switch self {
        case .allBikes:
            return "bikes"
        case .nearbyBikes(let latitude, let longitute, let radius):
            return "bikes?latitude=\(latitude)&longitude=\(longitute)&radius=\(radius)"
        case .createNewBike:
            return "bikes"
        case .updateBike(let info):
            return "bikes/\(info.id)"
        case .rentBike(let bikeId):
            return "bikes/\(bikeId)/rented"
        case .returnBike(let bikeId):
            return "bikes/\(bikeId)/rented"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allBikes, .nearbyBikes:
            return .get
        case .createNewBike:
            return .post
        case .updateBike, .rentBike:
            return .put
        case .returnBike:
            return .delete
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .allBikes, .nearbyBikes, .rentBike, .returnBike:
            return nil
        case .createNewBike(let req):
            return req.parameters()
        case .updateBike(let info):
            return info.request.parameters()
        }
    }
}
