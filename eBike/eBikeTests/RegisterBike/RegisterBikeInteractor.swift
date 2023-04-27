//
//  RegisterBikeInteractor.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike

final class MockRegisterBikeInteractor: RegisterBikeInteractorInterface {
   
    var isCreateNewBikeCalled: Bool = false
    
    weak var output: RegisterBikeInteractorOutput?
    
    func createNewBike(with requestBody: CreateNewBikeRequest) {
        isCreateNewBikeCalled = true
    }
}
