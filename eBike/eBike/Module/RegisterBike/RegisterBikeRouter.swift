//
//  RegisterBikeRouter.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import UIKit

// MARK: - RouterInterface

protocol RegisterBikeRouterInterface: RouterInterface { }

// MARK: - RegisterBikeRouter

final class RegisterBikeRouter {
    private weak var presenter: RegisterBikePresenter?
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule() -> UINavigationController {

        let interactor = RegisterBikeInteractor()
        let view = RegisterBikeViewController.instantiate()
        let navCon = UINavigationController(rootViewController: view)
        navCon.modalPresentationStyle = .fullScreen
        let router = RegisterBikeRouter(navigationController: navCon)
        let presenter = RegisterBikePresenter(router: router, interactor: interactor, view: view)
        router.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        
        return navCon
    }
}

// MARK: - RegisterBikeRouterInterface

extension RegisterBikeRouter: RegisterBikeRouterInterface { }
