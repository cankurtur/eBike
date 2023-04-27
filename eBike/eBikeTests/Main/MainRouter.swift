//
//  MainRouter.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike
import UIKit

final class MockMainRouter: MainRouterInterface {
  
    var isGetViewControllersCalled: Bool = false
    
    func getViewControllers() -> [UINavigationController] {
        isGetViewControllersCalled = true
        return [UINavigationController()]
    }
}
