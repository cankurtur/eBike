//
//  MainViewController.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike
import UIKit

final class MockMainViewController: MainViewInterface {
  
    var isPrepareUICalled: Bool = false
    var isDisplayCalled: Bool = false
    
    func prepareUI() {
        isPrepareUICalled = true
    }
    
    func display(_ viewControllers: [UIViewController], with currentIndex: Int) {
        isDisplayCalled = true
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

