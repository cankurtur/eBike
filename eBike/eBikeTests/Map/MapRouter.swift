//
//  MapRouter.swift
//  eBikeTests
//
//  Created by Can Kurtur on 26.04.2023.
//

@testable import eBike

final class MockMapRouter: MapRouterInterface {
    
    var isNavigateToRentBikeCalled: Bool = false
    
    func navigateToRentBike(with annotation: BikeAnnotation, delegate: RentBikePresenterDelegate?) {
        isNavigateToRentBikeCalled = true
    }
}
