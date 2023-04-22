//
//  MapViewController.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import UIKit
import MapKit

// MARK: - Constant

private enum Constant {
    static let backgroundColor: UIColor = .clear
    
    enum AnnotationView {
        static let glyphText: String = L10n.Map.Annotation.glyphText
        static let markerTintColor: UIColor = Colors.appGreen.color
    }
}

// MARK: - ViewInterface

protocol MapViewInterface: ViewInterface {
    func prepareUI()
    func configureAnnotations(nearbyBikesAnnotation: [BikeAnnotation])
    func render(_ location: CLLocation)
}

// MARK: - MapViewController

final class MapViewController: BaseViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        return mapView
    }()
    
    var presenter: MapPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - MapViewInterface

extension MapViewController: MapViewInterface {
    func prepareUI() {
        setupMapView()
    }
    
    func configureAnnotations(nearbyBikesAnnotation: [BikeAnnotation]) {
        mapView.removeAnnotationsIfNeeded(check: nearbyBikesAnnotation)
        mapView.addAnnotationsIfExist(nearbyBikesAnnotation)
    }
    
    func render(_ location: CLLocation) {
        mapView.setRegionMeterDistance(with: location, regionRadius: 500)
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? BikeAnnotation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "allBikesMapIdentifier") as? MKMarkerAnnotationView
        
        if let view = annotationView {
          view.annotation = annotation
        }
        else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "allBikesMapIdentifier")
        }
    
        annotationView?.glyphText = Constant.AnnotationView.glyphText
        annotationView?.markerTintColor = Constant.AnnotationView.markerTintColor
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let bikesAnnotation = view.annotation as? BikeAnnotation {
            presenter.didSelectAnnotation(annotation: bikesAnnotation)
        }
    }
}

// MARK: - Setups

private extension MapViewController {
    func setupMapView() {
        view.addSubview(mapView)
        mapView.edgesToSuperview()
    }
}

// MARK: - Array + BikesAnnotation

private extension Array where Element: MKAnnotation {
  var bikesAnnotation: [BikeAnnotation] {
    return compactMap { $0 as? BikeAnnotation }
  }
}

private extension MKMapView {
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


public extension MKMapView {
    func setRegionMeterDistance(with location: CLLocation, regionRadius: CLLocationDistance) {
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(region, animated: true)
    }
}
