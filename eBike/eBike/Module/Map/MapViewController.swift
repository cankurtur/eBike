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
        static let backgroundColor: UIColor = .white
        static let alpha: CGFloat = 1.0
        static let cornerRadius: CGFloat = 20
    }
    
    enum RefreshAnimationCircleView {
        static let activeBackgroundColor: UIColor = .clear
        static let passiveBackgroundColor: UIColor = .gray
        static let cornerRadius: CGFloat = 20
    }
    
    enum CurrentLocationButton {
        static let image: UIImage = UIImage(systemName: "location.fill")!.withRenderingMode(.alwaysOriginal).withTintColor(Colors.appGreen.color)
    }
    
    enum MapView {
        static let identifier: String = "allBikesMapIdentifier"
    }
}

// MARK: - ViewInterface

protocol MapViewInterface: ViewInterface {
    func prepareUI()
    func updateAnnotations(with annotations: [BikeAnnotation])
    func render(with location: CLLocation, and regionRadius: Double)
    func updateRefreshView(isEnable: Bool)
}

// MARK: - MapViewController

final class MapViewController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var refreshAnimationView: LottieAnimationView!
    @IBOutlet weak var refreshAnimationCircleView: UIView!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    static var storyboardName: StoryboardNames {
        return .map
    }
    
    var presenter: MapPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - MapViewInterface

extension MapViewController: MapViewInterface {
    func prepareUI() {
        prepareMapView()
        prepareViews()
        prepareButtons()
    }
    
    func updateAnnotations(with annotations: [BikeAnnotation]) {
        mapView.removeAnnotationsIfNeeded(check: annotations)
        mapView.addAnnotationsIfExist(annotations)
        view.layoutIfNeeded()
    }
    
    func render(with location: CLLocation, and regionRadius: Double) {
        mapView.setRegionMeterDistance(with: location, regionRadius: regionRadius)
    }
    
    func updateRefreshView(isEnable: Bool) {
        refreshAnimationView.isUserInteractionEnabled = isEnable
        refreshAnimationCircleView.backgroundColor = isEnable ? Constant.RefreshAnimationCircleView.activeBackgroundColor : Constant.RefreshAnimationCircleView.passiveBackgroundColor
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? BikeAnnotation else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: Constant.MapView.identifier) as? MKMarkerAnnotationView
        
        if let view = annotationView {
            view.annotation = annotation
        }
        else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: Constant.MapView.identifier)
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
    func prepareMapView() {
        mapView.delegate = self
    }
    
    func prepareViews() {
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
        
        refreshAnimationCircleView.layer.cornerRadius = Constant.RefreshAnimationCircleView.cornerRadius
        refreshAnimationCircleView.backgroundColor = Constant.RefreshAnimationCircleView.activeBackgroundColor
    }
    
    func prepareButtons() {
        currentLocationButton.setImage(Constant.CurrentLocationButton.image, for: .normal)
        currentLocationButton.contentVerticalAlignment = .fill
        currentLocationButton.contentHorizontalAlignment = .fill

        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
    }
}

// MARK: - Actions

@objc
private extension MapViewController {
    func refreshAnimationViewTapped() {
        refreshAnimationView.play()
        presenter.refreshAnimationViewTapped()
    }
    
    func currentLocationButtonTapped() {
        presenter.currentLocationButtonTapped()
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
