//
//  MyBikeViewController.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike

final class MockMyBikeViewController: MyBikeViewInterface {
    
    var isPrepareUICalled: Bool = false
    var isUpdateUIIfReturnBikeSuccessCalled: Bool = false
    
    func prepareUI(isOnTrip: Bool, pinText: String, bikeColorHex: String) {
        isPrepareUICalled = true
    }
    
    func updateUIIfReturnBikeSuccess() {
        isUpdateUIIfReturnBikeSuccessCalled = true
    }
    
    func showPopup(title: String, message: String) { }
    func showPopup(title: String, message: String, buttonTitle: String) { }
    func showPopup(title: String, message: String, buttonTitle: String, buttonAction: (() -> Void)?) { }
    func showPopup(error: APIClientError, buttonAction: (() -> Void)?) { }
    func showLocationAccessPopup() { }
    func showHUD() { }
    func showHUD(text: String, onMainThread: Bool) { }
    func dismissHUD() { }
}
