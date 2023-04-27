//
//  MapRouter.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import UIKit

// MARK: - RouterInterface

protocol MapRouterInterface: RouterInterface {
    func navigateToRentBike(with annotation: BikeAnnotation, delegate: RentBikePresenterDelegate?)
}

// MARK: - MapRouter

final class MapRouter {
    private weak var presenter: MapPresenter?
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> UINavigationController {

        let interactor = MapInteractor()
        let view = MapViewController.instantiate()
        let navCon = UINavigationController(rootViewController: view)
        navCon.modalPresentationStyle = .fullScreen
        let router = MapRouter(navigationController: navCon)
        let presenter = MapPresenter(router: router, interactor: interactor, view: view)
        router.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        
        return navCon
    }
}

// MARK: - MapRouterInterface

extension MapRouter: MapRouterInterface {
    func navigateToRentBike(with annotation: BikeAnnotation, delegate: RentBikePresenterDelegate?) {
        let view = RentBikeRouter.createModule(navigationController: navigationController, annotation: annotation, delegate: delegate)
        view.modalTransitionStyle = .crossDissolve
        if let sheet = view.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.preferredCornerRadius = 30
        }
        navigationController?.present(view, animated: true)
    }
}
