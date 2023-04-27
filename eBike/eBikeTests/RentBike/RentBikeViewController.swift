//
//  RentBikeViewController.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike

final class MockRentBikeViewController: RentBikeViewInterface {
    
    var isPrepareUICalled: Bool = false
    var isUpdateUIAfterRentBike: Bool = false
    var isShowHUDCalled: Bool = false
    
    func prepareUI(nameText: String, bikeHexString: String, pinText: String) {
        isPrepareUICalled = true
    }
    
    func updateUIAfterRentBike() {
        isUpdateUIAfterRentBike = true
    }
    
    func showPopup(title: String, message: String) { }
    func showPopup(title: String, message: String, buttonTitle: String) { }
    func showPopup(title: String, message: String, buttonTitle: String, buttonAction: (() -> Void)?) { }
    func showPopup(error: APIClientError, buttonAction: (() -> Void)?) { }
    func showLocationAccessPopup() { }
    func showHUD() {
        isShowHUDCalled = true
    }
    func showHUD(text: String, onMainThread: Bool) { }
    func dismissHUD() { }
}
