//
//  MockLocationManager.swift
//  eBikeTests
//
//  Created by Can Kurtur on 26.04.2023.
//

@testable import eBike
import CoreLocation

final class MockLocationManager: LocationManagerInterface {
    
    static let sharedMock = MockLocationManager()

    var isGetAuthorizationStatusCalled: Bool = false
    var isRequestWhenInUseAuthorizationCalled: Bool = false
    var isStartUpdatingLocationCalled: Bool = false
    var isGetCurrentLocationCalled: Bool = false

    var delegate: LocationManagerDelegate?
    
    func getAuthorizationStatus() -> CLAuthorizationStatus? {
        isGetAuthorizationStatusCalled = true
        return .authorizedAlways
    }
    
    func requestWhenInUseAuthorization() {
        isRequestWhenInUseAuthorizationCalled = true
    }
    
    func startUpdatingLocation() {
        isStartUpdatingLocationCalled = true
    }
    
    func getCurrentLocation() -> CLLocation? {
        isGetCurrentLocationCalled = true
        return CLLocation(latitude: CLLocationDegrees(50.119504), longitude: CLLocationDegrees(8.638137))
    }
}
