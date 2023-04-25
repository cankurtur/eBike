//
//  LocationManager.swift
//  eBike
//
//  Created by Can Kurtur on 22.04.2023.
//

import Foundation
import CoreLocation

// MARK: - LocationManagerDelegate

protocol LocationManagerDelegate: AnyObject {
    func shouldUpdateLocation(with currentLocation: CLLocation)
    func didChangeAuthorization(with status: CLAuthorizationStatus)
}

// MARK: - LocationManager

final class LocationManager: NSObject {
    
    static let shared: LocationManager = LocationManager()
    
    weak var delegate: LocationManagerDelegate?
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocation?
    private var lastLocation: CLLocation?
    private var locationTimer: Timer?
    
    override private init() {
        super.init()
        setupLocationManager()
        setupTimer()
        checkLocationManagerAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager?.stopUpdatingLocation()
    }
    
    func getCurrentLocation() -> CLLocation? {
        return currentLocation
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        measureDistanceBetweenLocations(currentLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.didChangeAuthorization(with: status)
    }
}

// MARK: - Helper

private extension LocationManager {
    func measureDistanceBetweenLocations(currentLocation: CLLocation) {
        guard let lastLocation = lastLocation else {
            self.lastLocation = currentLocation
            return
        }

        guard lastLocation.distance(from: currentLocation) >= 10 else {
            return
        }
        
        delegate?.shouldUpdateLocation(with: currentLocation)
        self.lastLocation = currentLocation
    }
    
    private func checkLocationManagerAuthorization() {
        switch locationManager?.authorizationStatus {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
        default:
            break
        }
    }
}

// MARK: - Setup

private extension LocationManager {
    func setupTimer() {
        locationTimer = Timer.scheduledTimer(timeInterval: 20,
                                     target: self,
                                     selector: #selector(updateLocation),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func setupLocationManager() {
        self.locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
}

// MARK: - Actions

@objc
private extension LocationManager {
    func updateLocation() {
        guard let currentLocation = currentLocation else { return }
        
        delegate?.shouldUpdateLocation(with: currentLocation)
    }
}


