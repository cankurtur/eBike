//
//  MKMapViewExtension.swift
//  eBike
//
//  Created by Can Kurtur on 22.04.2023.
//

import Foundation
import MapKit

extension MKMapView {
    func setRegionMeterDistance(with location: CLLocation, regionRadius: CLLocationDistance) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(region, animated: true)
    }
}
