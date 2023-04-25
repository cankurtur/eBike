//
//  ArrayExtension.swift
//  eBike
//
//  Created by Can Kurtur on 26.04.2023.
//

import MapKit

// MARK: - Array + BikesAnnotation

extension Array where Element: MKAnnotation {
  var bikesAnnotation: [BikeAnnotation] {
    return compactMap { $0 as? BikeAnnotation }
  }
}
