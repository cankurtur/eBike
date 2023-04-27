//
//  MyBikePresenterTests.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike
import XCTest

final class MyBikePresenterTests: XCTestCase {

    var sut: MyBikePresenter!
    var mockRouter: MockMyBikeRouter!
    var mockInteractor: MockMyBikeInteractor!
    var mockView: MockMyBikeViewController!
    var mockCurrentBike: BikeAnnotation!

    static let mockLocation: LocationResponseModel = LocationResponseModel(latitude: 50.119504, longitude: 8.638137)
    private var bikesResponseModel = BikesResponseModel(id: "0", name: "Can", color: "Black", pin: "0000", location: MyBikePresenterTests.mockLocation, rented: true)

    
    override func setUp() {
        mockRouter = MockMyBikeRouter()
        mockInteractor = MockMyBikeInteractor()
        mockView = MockMyBikeViewController()
        mockCurrentBike = BikeAnnotation(from: bikesResponseModel)
        sut = MyBikePresenter(router: mockRouter, interactor: mockInteractor, view: mockView)
        sut.locationManager = MockLocationManager()
        sut.notificationCenter = MockNotificationCenter()
        mockInteractor.output = sut
    }
    
    func test_viewDidLoad_success() {
        // Given
        XCTAssertFalse(mockView.isPrepareUICalled)
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertTrue(mockView.isPrepareUICalled)
    }
    
    func test_viewWillAppear_success() {
        // Given
        XCTAssertFalse(mockView.isPrepareUICalled)
        // When
        sut.viewWillAppear()
        // Then
        XCTAssertTrue(mockView.isPrepareUICalled)
    }
    
    func test_addNewBikeButtonTapped_success() {
        // Given
        XCTAssertFalse(mockRouter.isNavigateToMapCalled)
        // When
        sut.addNewBikeButtonTapped()
        // Then
        XCTAssertTrue(mockRouter.isNavigateToMapCalled)
    }
    
    func test_returnBikeButtonTapped_success() {
        // Given
        let orj_currentBike = UserDefaultsConfig.currentBike
        XCTAssertFalse(mockInteractor.isUpdateBikeCalled)
        UserDefaultsConfig.currentBike = mockCurrentBike
        // When
        sut.retunBikeButtonTapped()
        // Then
        XCTAssertTrue(mockInteractor.isUpdateBikeCalled)
        UserDefaultsConfig.currentBike = orj_currentBike
    }
}
