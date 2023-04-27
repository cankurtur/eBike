//
//  MapViewController.swift
//  eBikeTests
//
//  Created by Can Kurtur on 26.04.2023.
//

@testable import eBike
import CoreLocation

final class MockMapViewController: MapViewInterface {
   
    var isPrepareUICalled: Bool = false
    var isUpdateAnnotationsCalled: Bool = false
    var isRenderCalled: Bool = false
    var isUpdateRefreshViewCalled: Bool = false
    
    func prepareUI() {
        isPrepareUICalled = true
    }
    
    func updateAnnotations(with annotations: [BikeAnnotation]) {
        isUpdateAnnotationsCalled = true
    }
    
    func render(with location: CLLocation, and regionRadius: Double) {
        isRenderCalled = true
    }
    
    func updateRefreshView(isEnable: Bool) {
        isUpdateRefreshViewCalled = true
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
