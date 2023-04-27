//
//  LocationManagerTests.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

import XCTest
import CoreLocation

final class LocationManagerTests: XCTestCase {
    
    private var sut: MockLocationManager!
    
    override func setUp() {
        sut = MockLocationManager.sharedMock
    }

    func test_getAuthorizationStatus_success() {
        //Given
        XCTAssertFalse(sut.isGetAuthorizationStatusCalled)
        let expectedStatus = CLAuthorizationStatus.authorizedAlways
        
        //When
        let status = sut.getAuthorizationStatus()
        //Then
        XCTAssertTrue(sut.isGetAuthorizationStatusCalled)
        XCTAssertEqual(expectedStatus, status)
    }
    
    func test_requestWhenInUseAuthorization_success() {
        //Given
        XCTAssertFalse(sut.isRequestWhenInUseAuthorizationCalled)
        //When
        sut.requestWhenInUseAuthorization()
        //Then
        XCTAssertTrue(sut.isRequestWhenInUseAuthorizationCalled)
    }
    
    func test_startUpdatingLocation_success() {
        //Given
        XCTAssertFalse(sut.isStartUpdatingLocationCalled)
        //When
        sut.startUpdatingLocation()
        //Then
        XCTAssertTrue(sut.isStartUpdatingLocationCalled)
    }
    
    func test_getCurrentLocation_success() {
        //Given
        XCTAssertFalse(sut.isGetCurrentLocationCalled)
        //When
        let _ = sut.getCurrentLocation()
        //Then
        XCTAssertTrue(sut.isGetCurrentLocationCalled)
    }
}
