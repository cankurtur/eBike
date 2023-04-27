//
//  MockLocationManagerDelegateConformed.swift
//  eBikeTests
//
//  Created by Can Kurtur on 26.04.2023.
//
@testable import eBike
import CoreLocation

final class MockLocationManagerDelegateConformed: LocationManagerDelegate {
    
    var isShouldUpdateLocationCalled: Bool = false
    var isDidGetFirstLocationCalled: Bool = false
    var isDidChangeAuthorizationCalled: Bool = false
    
    func shouldUpdateLocation(with currentLocation: CLLocation) {
        isShouldUpdateLocationCalled = true
    }
    
    func didGetFirstLocation() {
        isDidGetFirstLocationCalled = true
    }
    
    func didChangeAuthorization() {
        isDidChangeAuthorizationCalled = true
    }
}
