//
//  RegisterBikePresenterTests.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

import XCTest

@testable import eBike
import XCTest

final class RegisterBikePresenterTests: XCTestCase {
    
    var sut: RegisterBikePresenter!
    var mockRouter: MockRegisterBikeRouter!
    var mockInteractor: MockRegisterBikeInteractor!
    var mockView: MockRegisterBikeViewController!
    var mockConfig: Config!
    
    
    override func setUp() {
        mockRouter = MockRegisterBikeRouter()
        mockInteractor = MockRegisterBikeInteractor()
        mockView = MockRegisterBikeViewController()
        mockConfig = Config.sharedInstance
        
        sut = RegisterBikePresenter(router: mockRouter, interactor: mockInteractor, view: mockView, config: mockConfig)
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
    
    
    func test_numberOfComponents_success() {
        // Given
        let expectedNumberOfComponents = 1
        // When
        let numberOfComponents = sut.numberOfComponents()
        // Then
        XCTAssertEqual(expectedNumberOfComponents, numberOfComponents)
    }
    
    
    func test_numberOfRowsInComponent_success() {
        // Given
        let expectedNumberOfRowsInComponent = 9
        let component = 1
        // When
        let numberOfRowsInComponent = sut.numberOfRowsInComponent(component)
        // Then
        XCTAssertEqual(expectedNumberOfRowsInComponent, numberOfRowsInComponent)
    }
    
    func test_titleForRow_success() {
        // Given
        let expectedTitle = "Black"
        let index = 0
        // When
        let title = sut.titleForRow(at: index)
        // Then
        XCTAssertEqual(expectedTitle, title)
    }
    
    func test_didSelectRow_success() {
        // Given
        let expectedTitle = "Black"
        let index = 0
        // When
        let title = sut.didSelectRow(at: index)
        // Then
        XCTAssertEqual(expectedTitle, title)
    }
    
    func test_registerButtonTapped_success() {
        // Given
        let name = "Can"
        let pin = "0000"
        let color = "Black"
        
        XCTAssertFalse(mockView.isShowHUDCalled)
        XCTAssertFalse(mockInteractor.isCreateNewBikeCalled)
        // When
        sut.registerButtonTapped(name: name, pin: pin, color: color)
        // Then
        XCTAssertTrue(mockView.isShowHUDCalled)
        XCTAssertTrue(mockInteractor.isCreateNewBikeCalled)
    }
    
    func test_textFieldDidEndEditing_success() {
        // Given
        let name = ""
        let pin = ""
        let color = ""
        
        // When
        let endEditing = sut.textFieldDidEndEditing(name: name, pin: pin, color: color)
        // Then
        XCTAssertTrue(endEditing)
    }
    
}
