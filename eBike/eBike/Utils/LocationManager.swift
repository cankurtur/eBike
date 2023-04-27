//
//  LocationManager.swift
//  eBike
//
//  Created by Can Kurtur on 22.04.2023.
//

import Foundation
import CoreLocation

protocol LocationManagerInterface {
    var delegate: LocationManagerDelegate? { get set }
    func getAuthorizationStatus() -> CLAuthorizationStatus?
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    func getCurrentLocation() -> CLLocation?
}

// MARK: - LocationManagerDelegate

protocol LocationManagerDelegate: AnyObject {
    func shouldUpdateLocation(with currentLocation: CLLocation)
    func didGetFirstLocation()
    func didChangeAuthorization()
}

// MARK: - LocationManager

final class LocationManager: NSObject, LocationManagerInterface {
    
    static let shared: LocationManager = LocationManager()
    
    weak var delegate: LocationManagerDelegate?
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocation?
    private var lastLocation: CLLocation?
    private var locationTimer: Timer?
    private var isNeedFirstLocation: Bool = true
    
    override private init() {
        super.init()
        setupLocationManager()
        setupTimer()
    }
    
    func getAuthorizationStatus() -> CLAuthorizationStatus? {
        locationManager?.authorizationStatus
    }
    
    func requestWhenInUseAuthorization() {
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager?.startUpdatingLocation()
    }
    
    func getCurrentLocation() -> CLLocation? {
        return currentLocation
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        if isNeedFirstLocation {
            currentLocation = location
            delegate?.didGetFirstLocation()
            isNeedFirstLocation = false
        }
        
        currentLocation = location
        measureDistanceBetweenLocations(currentLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.didChangeAuthorization()
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


