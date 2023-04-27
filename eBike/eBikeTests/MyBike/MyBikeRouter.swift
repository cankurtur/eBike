//
//  MyBikeRouter.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike

final class MockMyBikeRouter: MyBikeRouterInterface {
    
    var isNavigateToMapCalled: Bool = false
    
    func navigateToMap() {
        isNavigateToMapCalled = true
    }
}
