//
//  MapInteractor.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation

// MARK: - InteractorInterface

protocol MapInteractorInterface: InteractorInterface {
    func getNearbyBikes(latitude: Double, longitude: Double, radius: Double)
}

// MARK: - InteractorOutput

protocol MapInteractorOutput: AnyObject {
    func onGetNearbyBikesReceived(_ result: Result<[BikesResponseModel], APIClientError>)
}

// MARK: -  MapInteractor

final class MapInteractor {
    weak var output: MapInteractorOutput?
    private var networkManager: NetworkManager<BikesEndpointItem>
    
    init() {
        networkManager = NetworkManager<BikesEndpointItem>()
    }
}

// MARK: - MapInteractorInterface

extension MapInteractor: MapInteractorInterface {
    func getNearbyBikes(latitude: Double, longitude: Double, radius: Double) {
        networkManager.request(endpoint: .nearbyBikes(latitude: latitude, longitude: longitude, radius: radius), type: [BikesResponseModel].self) { [weak self] result in
            guard let self = self else { return }
            
            self.output?.onGetNearbyBikesReceived(result)
        }
    }
}
