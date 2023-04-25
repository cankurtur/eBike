//
//  MapPresenter.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation
import CoreLocation

// MARK: - Constant

private enum Constant {
    static let refreshTime: TimeInterval = 10
}

// MARK: - PresenterInterface

protocol MapPresenterInterface: PresenterInterface {
    func didSelectAnnotation(annotation: BikeAnnotation)
    func refreshAnimationViewTapped()
    func currentLocationButtonTapped()
}

// MARK: - MapPresenter

final class MapPresenter {
    private let router: MapRouterInterface
    private let interactor: MapInteractorInterface
    private weak var view: MapViewInterface?
    private let locationManager: LocationManager
    private let config: Config
    private let notificationCenter: NotificationCenterProtocol?
    private var refreshTimer: Timer?
    
    init(router: MapRouterInterface,
         interactor: MapInteractorInterface,
         view: MapViewInterface?,
         locationManager: LocationManager = LocationManager.shared,
         config: Config = Config.sharedInstance,
         notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.locationManager = locationManager
        self.config = config
        self.notificationCenter = notificationCenter
    }
    
}

// MARK: - MapPresenterInterface

extension MapPresenter: MapPresenterInterface {
    func viewDidLoad() {
        view?.prepareUI()
        locationManager.delegate = self
        
        notificationCenter?.add(
            observer: self,
            selector: #selector(shouldUpdateMap),
            name: .shouldUpdateMap,
            object: nil
        )
        
        fetchBikes()
    }
    
    func didSelectAnnotation(annotation: BikeAnnotation) {
        router.navigateToRentBike(with: annotation, delegate: self)
    }
    
    func refreshAnimationViewTapped() {
        fetchBikesIfRefreshEnable()
    }
    
    func currentLocationButtonTapped() {
        renderMapWithCurrentLocation()
    }
}

// MARK: - MapInteractorOutput

extension MapPresenter: MapInteractorOutput {
    func onGetNearbyBikesReceived(_ result: Result<[BikesResponseModel], APIClientError>) {
        view?.dismissHUD()
        switch result {
        case .success(let bikes):
            let allBikesAnnotations = bikes.map({ BikeAnnotation(from: $0 )})
            let availableBikesAnnotations = allBikesAnnotations.filter { $0.rented == false }
            
            DispatchQueue.main.async { [weak self] in
                self?.view?.updateAnnotations(with: availableBikesAnnotations)
            }
        case.failure(let error):
            view?.showPopup(error: error, buttonAction: nil)
            print(error)
        }
    }
}

// MARK: - LocationManagerDelegate

extension MapPresenter: LocationManagerDelegate {
    func shouldUpdateLocation(with currentLocation: CLLocation) {
        interactor.getNearbyBikes(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, radius: config.regionRadius)
    }
    
    func didChangeAuthorization(with status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: - RentBikePresenterDelegate

extension MapPresenter: RentBikePresenterDelegate {
    func shouldDismissRentView() {
        fetchBikes()
    }
}

// MARK: - Helper

private extension MapPresenter {
    func fetchBikes() {
        guard let currentLocation = locationManager.getCurrentLocation() else { return }
        
        view?.showHUD()
        interactor.getNearbyBikes(
            latitude: currentLocation.coordinate.latitude,
            longitude: currentLocation.coordinate.longitude,
            radius: config.regionRadius
        )
    }
    
    func fetchBikesIfRefreshEnable() {
        guard refreshTimer == nil else { return }
        
        refreshTimer = Timer.scheduledTimer(timeInterval: Constant.refreshTime,
                                                        target: self,
                                                        selector: #selector(updateUIWhenRefreshTimerEnd),
                                                        userInfo: nil,
                                                        repeats: false)
        fetchBikes()
        view?.updateRefreshView(isEnable: false)
        renderMapWithCurrentLocation()
    }
    
    func renderMapWithCurrentLocation() {
        guard let currentLocation = locationManager.getCurrentLocation() else { return }
        
        view?.render(with: currentLocation, and: config.regionRadius)
    }
}

// MARK: - Actions

@objc
private extension MapPresenter {
    func shouldUpdateMap() {
        fetchBikes()
    }
    
    func updateUIWhenRefreshTimerEnd() {
        refreshTimer = nil
        view?.updateRefreshView(isEnable: true)
    }
}
