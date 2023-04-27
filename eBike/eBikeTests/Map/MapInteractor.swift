//
//  MapInteractor.swift
//  eBikeTests
//
//  Created by Can Kurtur on 26.04.2023.
//

@testable import eBike

final class MockMapInteractor: MapInteractorInterface {
   
    var isGetNearbyBikesCalled: Bool = false
    
    weak var output: MapInteractorOutput?
    
    func getNearbyBikes(latitude: Double, longitude: Double, radius: Double) {
        isGetNearbyBikesCalled = true
    }
}
