//
//  BasePresenter.swift
//  eBike
//
//  Created by Can Kurtur on 25.04.2023.
//

import Foundation
import CoreLocation

// MARK: - BasePresenter

class BasePresenter {
    private let router: RouterInterface
    private let interactor: InteractorInterface
    private weak var view: ViewInterface?
    var locationManager: LocationManagerInterface
    var notificationCenter: NotificationCenterProtocol?
    
    var hasLocationPermission: Bool {
        guard let status = locationManager.getAuthorizationStatus() else {
            view?.showPopup(title: L10n.AppPopupView.oops, message: L10n.AppPopupView.somethingWentWrong)
            return false
        }
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }
    
    init(router: RouterInterface,
         interactor: InteractorInterface,
         view: ViewInterface?,
         locationManager: LocationManagerInterface = LocationManager.shared,
         notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.locationManager = locationManager
        self.notificationCenter = notificationCenter
    }
    
    func handleLocationPermission() {
        guard let status = locationManager.getAuthorizationStatus() else {
            view?.showPopup(title: L10n.AppPopupView.oops, message: L10n.AppPopupView.somethingWentWrong)
            return
        }
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            view?.showLocationAccessPopup()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            break
        }
    }
}
