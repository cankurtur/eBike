//
//  RentBikePresenterTests.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike
import XCTest

final class RentBikePresenterTests: XCTestCase {
    
    var sut: RentBikePresenter!
    var mockRouter: MockRentBikeRouter!
    var mockInteractor: MockRentBikeInteractor!
    var mockView: MockRentBikeViewController!
    
    private static let mockLocation: LocationResponseModel = LocationResponseModel(latitude: 50.119504, longitude: 8.638137)
    
    static var bikesResponseModel: [BikesResponseModel]?
    static var mockAnnotation: BikeAnnotation = BikeAnnotation(from: BikesResponseModel(
        id: "0", name: "mockName", color: "000000", pin: "0000", location: RentBikePresenterTests.mockLocation, rented: false))

    override func setUp() {
        mockRouter = MockRentBikeRouter()
        mockInteractor = MockRentBikeInteractor()
        mockView = MockRentBikeViewController()
        sut = RentBikePresenter(router: mockRouter, interactor: mockInteractor, view: mockView, annotation: RentBikePresenterTests.mockAnnotation, delegate: nil)
        sut.locationManager = MockLocationManager()
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
    
    func test_rentButtonTapped_success() {
        // Given
        XCTAssertFalse(mockView.isShowHUDCalled)
        XCTAssertFalse(mockInteractor.isRentBikeCalled)
        // When
        sut.rentButtonTapped()
        // Then
        XCTAssertTrue(mockView.isShowHUDCalled)
        XCTAssertTrue(mockInteractor.isRentBikeCalled)
    }
    
    
    func test_iGotItButtonTapped_success() {
        // Given
        XCTAssertFalse(mockRouter.isDismissCalled)
        // When
        sut.iGotItButtonTapped()
        // Then
        XCTAssertTrue(mockRouter.isDismissCalled)
    }
    
}
