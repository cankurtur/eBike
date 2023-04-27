//
//  RegisterBikeViewController.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike

final class MockRegisterBikeViewController: RegisterBikeViewInterface {
    
    var isPrepareUICalled: Bool = false
    var isUpdateUIAfterRegisterCalled: Bool = false
    var isShowHUDCalled: Bool = false
    
    func prepareUI() {
        isPrepareUICalled = true
    }
    
    func updateUIAfterRegister() {
        isUpdateUIAfterRegisterCalled = true
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
