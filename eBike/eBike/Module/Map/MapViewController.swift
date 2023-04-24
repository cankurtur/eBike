//
//  MapViewController.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import UIKit
import MapKit
import Lottie

// MARK: - Constant

private enum Constant {
    static let backgroundColor: UIColor = .clear
    
    enum AnnotationView {
        static let glyphText: String = L10n.Map.Annotation.glyphText
        static let markerTintColor: UIColor = Colors.appGreen.color
    }
    
    enum RefreshAnimationView {
        static let animationName: String = Animations.refresh.rawValue
        static let backgroundColor: UIColor = .clear
        static let alpha: CGFloat = 1.0
        static let cornerRadius: CGFloat = 20
        static let heightConstant: CGFloat = 44
        static let widthConstant: CGFloat = 44
        static let topConstant: CGFloat = 60
        static let trailingConstant: CGFloat = 30
    }
}

// MARK: - ViewInterface

protocol MapViewInterface: ViewInterface {
    func prepareUI()
    func updateAnnotations(with annotations: [BikeAnnotation])
    func render(with location: CLLocation, and regionRadius: Double)
}

// MARK: - MapViewController

final class MapViewController: BaseViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        return mapView
    }()
    
    private lazy var refreshAnimationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: Constant.RefreshAnimationView.animationName)
        return animationView
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
        setup()
        prepare()
    }
    
    func updateAnnotations(with annotations: [BikeAnnotation]) {
        mapView.removeAnnotationsIfNeeded(check: annotations)
        mapView.addAnnotationsIfExist(annotations)
        view.layoutIfNeeded()
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

// MARK: - Prepares

private extension MapViewController {
    func prepare() {
        prepareAnimationViews()
    }
    
    func prepareAnimationViews() {
        refreshAnimationView.backgroundColor = Constant.RefreshAnimationView.backgroundColor
        refreshAnimationView.alpha = Constant.RefreshAnimationView.alpha
        refreshAnimationView.loopMode = .playOnce
        refreshAnimationView.contentMode = .scaleAspectFill
        refreshAnimationView.layer.cornerRadius = Constant.RefreshAnimationView.cornerRadius
        refreshAnimationView.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(refreshAnimationViewTapped))
        )
        refreshAnimationView.play()
    }
}

// MARK: - Setups

private extension MapViewController {
    func setup() {
        setupMapView()
        setupRefreshAnimationView()
    }
    
    func setupMapView() {
        view.addSubview(mapView)
        mapView.edgesToSuperview()
    }
    
    func setupRefreshAnimationView() {
        view.addSubview(refreshAnimationView)
        refreshAnimationView.edgesToItself(to: [
            .height(Constant.RefreshAnimationView.heightConstant),
            .width(Constant.RefreshAnimationView.widthConstant)
        ])
        refreshAnimationView.edgesTo(view, to: [
            .top(Constant.RefreshAnimationView.topConstant),
            .trailing(Constant.RefreshAnimationView.trailingConstant)
        ])
    }
}

// MARK: - Actions

@objc
private extension MapViewController {
    func refreshAnimationViewTapped() {
        refreshAnimationView.play()
        presenter.refreshAnimationViewTapped()
    }
}


// MARK: - Array + BikesAnnotation

private extension Array where Element: MKAnnotation {
  var bikesAnnotation: [BikeAnnotation] {
    return compactMap { $0 as? BikeAnnotation }
  }
}

// MARK: - MKMapView + Remove Annotations

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
