//
//  RegisterBikeInteractor.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import Foundation

// MARK: - InteractorInterface

protocol RegisterBikeInteractorInterface: InteractorInterface {
    func createNewBike(with requestBody: CreateNewBikeRequest)
}

// MARK: - RegisterBikeInteractorOutput

protocol RegisterBikeInteractorOutput: AnyObject {
    func onGetCreateNewBikeReceived(_ result: Result<EmptyResponse, APIClientError>)
}

// MARK: - RegisterBikeInteractor

final class RegisterBikeInteractor {
    weak var output: RegisterBikeInteractorOutput?
    
    private var networkManager: NetworkManager<BikesEndpointItem>
    
    init() {
        networkManager = NetworkManager<BikesEndpointItem>()
    }
}

// MARK: - RegisterBikeInteractorInterface
extension RegisterBikeInteractor: RegisterBikeInteractorInterface {
    func createNewBike(with requestBody: CreateNewBikeRequest) {
        networkManager.request(endpoint: .createNewBike(request: requestBody), type: EmptyResponse.self) { [weak self] result in
            guard let self = self else { return }

            self.output?.onGetCreateNewBikeReceived(result)
        }
    }
}

