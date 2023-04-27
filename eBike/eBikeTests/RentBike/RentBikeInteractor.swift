//
//  RentBikeInteractor.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike

final class MockRentBikeInteractor: RentBikeInteractorInterface {
   
    var isRentBikeCalled: Bool = false
    
    weak var output: RentBikeInteractorOutput?
    
    func rentBike(with bikeID: Int) {
        isRentBikeCalled = true
    }
}
