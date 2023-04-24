//
//  MapPresenter.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation
import CoreLocation

// MARK: - Constant

private enum Constant { }

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
        fetchBikes()
    }
    
    func currentLocationButtonTapped() {
        guard let currentLocation = locationManager.getCurrentLocation() else { return }
        
        view?.render(with: currentLocation, and: config.regionRadius)
    }
}

// MARK: - MapInteractorOutput

extension MapPresenter: MapInteractorOutput {
    func onGetNearbyBikesReceived(_ result: Result<[BikesResponseModel], APIClientError>) {
        switch result {
        case .success(let bikes):
            let allBikesAnnotations = bikes.map({ BikeAnnotation(from: $0 )})
            let availableBikesAnnotations = allBikesAnnotations.filter { $0.rented == false }
            
            DispatchQueue.main.async { [weak self] in
                self?.view?.updateAnnotations(with: availableBikesAnnotations)
            }
        case.failure(let error):
            //            SwiftMessagesManager.shared.showAPIClientErrorPopup(error: error)
            print(error)
        }
    }
}

// MARK: - LocationManagerDelegate

extension MapPresenter: LocationManagerDelegate {
    func didUpdateLocation(with currentLocation: CLLocation) {
        view?.render(with: currentLocation, and: config.regionRadius)
    }
    
    func shouldUpdateLocation(with currentLocation: CLLocation) {
        interactor.getNearbyBikes(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, radius: config.regionRadius)
    }
    
    func didChangeAuthorization(with status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
            LocationManager.shared.startUpdatingLocation()
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
        
        interactor.getNearbyBikes(
            latitude: currentLocation.coordinate.latitude,
            longitude: currentLocation.coordinate.longitude,
            radius: config.regionRadius
        )
    }
}

// MARK: - Actions

@objc
private extension MapPresenter {
    func shouldUpdateMap() {
        fetchBikes()
    }
}
