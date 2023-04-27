//
//  MapPresenterTests.swift
//  eBikeTests
//
//  Created by Can Kurtur on 26.04.2023.
//

@testable import eBike
import XCTest

final class MapPresenterTests: XCTestCase {
   
    var sut: MapPresenter!
    var mockRouter: MockMapRouter!
    var mockInteractor: MockMapInteractor!
    var mockView: MockMapViewController!
    var mockConfig: Config!
    
    static var bikesResponseModel: [BikesResponseModel]?
    static var mockAnnotation: BikeAnnotation = BikeAnnotation(from: BikesResponseModel(
        id: nil, name: nil, color: nil, pin: nil, location: nil, rented: nil))

    override func setUp() {
        mockRouter = MockMapRouter()
        mockInteractor = MockMapInteractor()
        mockView = MockMapViewController()
        mockConfig = Config.sharedInstance
        
        sut = MapPresenter(router: mockRouter, interactor: mockInteractor, view: mockView, config: mockConfig)
        sut.locationManager = MockLocationManager()
        sut.locationManager.delegate = MockLocationManagerDelegateConformed()
        sut.notificationCenter = MockNotificationCenter()
        mockInteractor.output = sut
    }
    
    private func modifyPresenter() {
        sut.onGetNearbyBikesReceived(.success(MapPresenterTests.bikesResponseModel!))
    }
    
    func test_viewDidLoad_success() {
        // Given
        XCTAssertFalse(mockView.isPrepareUICalled)
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertTrue(mockView.isPrepareUICalled)
    }
    
    func test_didSelectAnnotation_success() {
        // Given
        XCTAssertFalse(mockRouter.isNavigateToRentBikeCalled)
        let annotation = MapPresenterTests.mockAnnotation
        // When
        sut.didSelectAnnotation(annotation: annotation)
        // Then
        XCTAssertTrue(mockRouter.isNavigateToRentBikeCalled)
    }
    
    func test_refreshAnimationViewTapped_success() {
        // Given
        XCTAssertFalse(mockView.isUpdateRefreshViewCalled)
        XCTAssertFalse(mockInteractor.isGetNearbyBikesCalled)
        XCTAssertFalse(mockView.isUpdateRefreshViewCalled)
        // When
        sut.refreshAnimationViewTapped()
        // Then
        XCTAssertTrue(mockView.isUpdateRefreshViewCalled)
        XCTAssertTrue(mockInteractor.isGetNearbyBikesCalled)
        XCTAssertTrue(mockView.isUpdateRefreshViewCalled)
    }
    
    func test_currentLocationButtonTapped_success() {
        // Given
        XCTAssertFalse(mockView.isRenderCalled)
        // When
        sut.currentLocationButtonTapped()
        // Then
        XCTAssertTrue(mockView.isRenderCalled)
    }
}
