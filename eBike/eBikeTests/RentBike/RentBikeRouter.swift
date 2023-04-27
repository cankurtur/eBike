//
//  RentBikeRouter.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike

final class MockRentBikeRouter: RentBikeRouterInterface {
   
    var isDismissCalled: Bool = false
    
    func dismiss() {
        isDismissCalled = true
    }
}
