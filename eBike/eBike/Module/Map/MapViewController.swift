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
    func updateAnnotations(with annotations: [MKAnnotation])
    func render(with location: CLLocation, and regionRadius: Double)
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
    
    func updateAnnotations(with annotations: [MKAnnotation]) {
        mapView.removeAnnotations(annotations)
        mapView.addAnnotations(annotations)
    }
    
    func render(with location: CLLocation, and regionRadius: Double) {
        mapView.setRegionMeterDistance(with: location, regionRadius: regionRadius)
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
        guard let bikeAnnotation = view.annotation as? BikeAnnotation else { return }
       
        presenter.didSelectAnnotation(annotation: bikeAnnotation)
    }
}

// MARK: - Setups

private extension MapViewController {
    func setupMapView() {
        view.addSubview(mapView)
        mapView.edgesToSuperview()
    }
}
