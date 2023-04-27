//
//  MainPresenterTests.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike
import XCTest

final class MainPresenterTests: XCTestCase {

    var sut: MainPresenter!
    var mockRouter: MockMainRouter!
    var mockInteractor: MockMainInteractor!
    var mockView: MockMainViewController!

    override func setUp() {
        mockRouter = MockMainRouter()
        mockInteractor = MockMainInteractor()
        mockView = MockMainViewController()

        sut = MainPresenter(router: mockRouter, interactor: mockInteractor, view: mockView, tabType: .map)
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

    func test_SetupViewControllers_success() {
        // Given
        XCTAssertFalse(mockRouter.isGetViewControllersCalled)
        XCTAssertFalse(mockView.isDisplayCalled)
        // When
        sut.setupViewControllers()
        // Then
        XCTAssertTrue(mockRouter.isGetViewControllersCalled)
        XCTAssertTrue(mockView.isDisplayCalled)
    }
}
