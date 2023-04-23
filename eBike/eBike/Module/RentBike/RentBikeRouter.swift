//
//  RentBikeRouter.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import UIKit

// MARK: - RouterInterface

protocol RentBikeRouterInterface: RouterInterface {
    func dismiss()
}

// MARK: - RentBikeRouter

final class RentBikeRouter {
    private weak var presenter: RentBikePresenter?
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(navigationController: UINavigationController? = nil, annotation: BikeAnnotation, delegate: RentBikePresenterDelegate?) -> UIViewController {

        let interactor = RentBikeInteractor()
        let view = RentBikeViewController.instantiate()
        let navCon = navigationController ?? UINavigationController(rootViewController: view)
        navCon.modalPresentationStyle = .pageSheet
        let router = RentBikeRouter(navigationController: navCon)
        let presenter = RentBikePresenter(router: router, interactor: interactor, view: view, annotation: annotation, delegate: delegate)
        router.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        
        return navigationController == nil ? navCon : view
    }
}

// MARK: - RentBikeRouterInterface

extension RentBikeRouter: RentBikeRouterInterface {
    func dismiss() {
        navigationController?.dismiss(animated: true)
    }
}
