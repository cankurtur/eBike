//
//  MyBikeInteractor.swift
//  eBike
//
//  Created by Can Kurtur on 24.04.2023.
//

import Foundation

// MARK: - InteractorInterface

protocol MyBikeInteractorInterface: InteractorInterface {
    func updateBike(with updateBikeInfo: UpdateBikeInfo)
    func MyBike(with bikeID: Int)
}

// MARK: - MyBikeInteractorOutput

protocol MyBikeInteractorOutput: AnyObject {
    func onUpdateBikeReceived(_ result: Result<EmptyResponse, APIClientError>)
    func onMyBikeReceived(_ result: Result<EmptyResponse, APIClientError>)
}

// MARK: - MyBikeInteractor

final class MyBikeInteractor {
    weak var output: MyBikeInteractorOutput?
    
    private var networkManager: NetworkManager<BikesEndpointItem>
    
    init() {
        networkManager = NetworkManager<BikesEndpointItem>()
    }
}

// MARK: - MyBikeInteractorInterface

extension MyBikeInteractor: MyBikeInteractorInterface {
    func updateBike(with updateBikeInfo: UpdateBikeInfo) {
        networkManager.request(endpoint: .updateBike(info: updateBikeInfo), type: EmptyResponse.self) { [weak self] result in
            guard let self = self else { return }
            
            self.output?.onUpdateBikeReceived(result)
        }
    }
    
    func MyBike(with bikeID: Int) {
        networkManager.request(endpoint: .returnBike(bikeId: bikeID), type: EmptyResponse.self) { [weak self] result in
            guard let self = self else { return }
            
            self.output?.onMyBikeReceived(result)
        }
    }
}
