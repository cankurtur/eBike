//
//  ReturnBikeRouter.swift
//  eBike
//
//  Created by Can Kurtur on 24.04.2023.
//

import UIKit

// MARK: - RouterInterface

protocol ReturnBikeRouterInterface: RouterInterface {
    func navigateToMap()
}

// MARK: - ReturnBikeRouter

final class ReturnBikeRouter {
    private weak var presenter: ReturnBikePresenter?
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> UINavigationController {

        let interactor = ReturnBikeInteractor()
        let view = ReturnBikeViewController.instantiate()
        let navCon = UINavigationController(rootViewController: view)
        navCon.modalPresentationStyle = .fullScreen
        let router = ReturnBikeRouter(navigationController: navCon)
        let presenter = ReturnBikePresenter(router: router, interactor: interactor, view: view)
        router.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        
        return navCon
    }
}

// MARK: - ReturnBikeRouterInterface

extension ReturnBikeRouter: ReturnBikeRouterInterface {
    func navigateToMap() {
        navigationController?.tabBarController?.selectedIndex = TabType.map.rawValue
    }
}
