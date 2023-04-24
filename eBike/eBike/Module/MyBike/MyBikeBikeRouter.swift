//
//  MyBikeRouter.swift
//  eBike
//
//  Created by Can Kurtur on 24.04.2023.
//

import UIKit

// MARK: - RouterInterface

protocol MyBikeRouterInterface: RouterInterface {
    func navigateToMap()
}

// MARK: - MyBikeRouter

final class MyBikeRouter {
    private weak var presenter: MyBikePresenter?
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> UINavigationController {

        let interactor = MyBikeInteractor()
        let view = MyBikeViewController.instantiate()
        let navCon = UINavigationController(rootViewController: view)
        navCon.modalPresentationStyle = .fullScreen
        let router = MyBikeRouter(navigationController: navCon)
        let presenter = MyBikePresenter(router: router, interactor: interactor, view: view)
        router.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        
        return navCon
    }
}

// MARK: - MyBikeRouterInterface

extension MyBikeRouter: MyBikeRouterInterface {
    func navigateToMap() {
        navigationController?.tabBarController?.selectedIndex = TabType.map.rawValue
    }
}
