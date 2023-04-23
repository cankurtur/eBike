//
//  RentBikeInteractor.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import Foundation

// MARK: - InteractorInterface

protocol RentBikeInteractorInterface: InteractorInterface {
    func rentBike(with bikeID: Int)
}

// MARK: - RentBikeInteractorOutput

protocol RentBikeInteractorOutput: AnyObject {
    func onRentBikeReceived(_ result: Result<EmptyResponse, APIClientError>)
}

// MARK: - RentBikeInteractor

final class RentBikeInteractor {
    weak var output: RentBikeInteractorOutput?
    
    private var networkManager: NetworkManager<BikesEndpointItem>
    
    init() {
        networkManager = NetworkManager<BikesEndpointItem>()
    }
}

// MARK: - RentBikeInteractorInterface

extension RentBikeInteractor: RentBikeInteractorInterface {
    func rentBike(with bikeID: Int) {
        networkManager.request(endpoint: .rentBike(bikeId: bikeID), type: EmptyResponse.self) { [weak self] result in
            guard let self = self else { return }

            self.output?.onRentBikeReceived(result)
        }
    }
}
