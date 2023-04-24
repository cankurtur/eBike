//
//  ReturnBikeInteractor.swift
//  eBike
//
//  Created by Can Kurtur on 24.04.2023.
//

import Foundation

// MARK: - InteractorInterface

protocol ReturnBikeInteractorInterface: InteractorInterface {
    func updateBike(with updateBikeInfo: UpdateBikeInfo)
    func returnBike(with bikeID: Int)
}

// MARK: - ReturnBikeInteractorOutput

protocol ReturnBikeInteractorOutput: AnyObject {
    func onUpdateBikeReceived(_ result: Result<EmptyResponse, APIClientError>)
    func onReturnBikeReceived(_ result: Result<EmptyResponse, APIClientError>)
}

// MARK: - ReturnBikeInteractor

final class ReturnBikeInteractor {
    weak var output: ReturnBikeInteractorOutput?
    
    private var networkManager: NetworkManager<BikesEndpointItem>
    
    init() {
        networkManager = NetworkManager<BikesEndpointItem>()
    }
}

// MARK: - ReturnBikeInteractorInterface

extension ReturnBikeInteractor: ReturnBikeInteractorInterface {
    func updateBike(with updateBikeInfo: UpdateBikeInfo) {
        networkManager.request(endpoint: .updateBike(info: updateBikeInfo), type: EmptyResponse.self) { [weak self] result in
            guard let self = self else { return }
            
            self.output?.onUpdateBikeReceived(result)
        }
    }
    
    func returnBike(with bikeID: Int) {
        networkManager.request(endpoint: .returnBike(bikeId: bikeID), type: EmptyResponse.self) { [weak self] result in
            guard let self = self else { return }
            
            self.output?.onReturnBikeReceived(result)
        }
    }
}
