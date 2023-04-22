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
}

// MARK: - MapPresenter

final class MapPresenter {
    private let router: MapRouterInterface
    private let interactor: MapInteractorInterface
    private weak var view: MapViewInterface?
    private let locationManager: LocationManager

    init(router: MapRouterInterface, interactor: MapInteractorInterface, view: MapViewInterface?, locationManager: LocationManager = LocationManager.shared) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.locationManager = locationManager
    }

}

// MARK: - MapPresenterInterface

extension MapPresenter: MapPresenterInterface {
    func viewDidLoad() {
        view?.prepareUI()
        locationManager.delegate = self
        
        guard let currentLocation = locationManager.getCurrentLocation() else { return }
        
        interactor.getNearbyBikes(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, radius: 500)
    }
    
    func didSelectAnnotation(annotation: BikeAnnotation) {
        // TODO: Add action
    }
}

// MARK: - MapInteractorOutput

extension MapPresenter: MapInteractorOutput {
    func onGetNearbyBikesReceived(_ result: Result<[BikesResponseModel], APIClientError>) {
        switch result {
        case .success(let bikes):
            let allBikesAnnotationArray = bikes.map({ BikeAnnotation(bikesResponseModel: $0 )})
            let availableBikesAnnotationArray = allBikesAnnotationArray.filter { $0.rented == false }
           
            DispatchQueue.main.async { [weak self] in
                self?.view?.configureAnnotations(nearbyBikesAnnotation: availableBikesAnnotationArray)
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
        view?.render(currentLocation)
    }
    
    func shouldUpdateLocation(with currentLocation: CLLocation) {
        interactor.getNearbyBikes(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, radius: 500)
    }
    
    func didChangeAuthorization(with status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
            LocationManager.shared.startUpdatingLocation()
        }
    }
}
