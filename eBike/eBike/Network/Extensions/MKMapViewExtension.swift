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

// MARK: - MKMapView + Remove Annotations

extension MKMapView {
  func removeAnnotationsIfNeeded(check newAnnotations: [BikeAnnotation]) {
    guard !newAnnotations.isEmpty else {
      removeAnnotations(annotations)
      return
    }
    annotations.bikesAnnotation.forEach { existingAnnotation in
      if !newAnnotations.contains(existingAnnotation),
         let redundantAnnotation = annotations.bikesAnnotation.first(where: { $0 == existingAnnotation })
      {
        removeAnnotation(redundantAnnotation as MKAnnotation)
      }
    }
  }

  func addAnnotationsIfExist(_ annotations: [BikeAnnotation]) {
    if !annotations.isEmpty {
      addAnnotations(annotations)
    }
  }
}
