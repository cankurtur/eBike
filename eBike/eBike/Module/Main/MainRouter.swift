//
//  MainRouter.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//


import UIKit

// MARK: - Constant

private enum Constant {
    struct TabBarItem {
        static let titleFont: UIFont = FontFamily.CircularSpotifyText.bold.font(size: 12)
        static let selectedTitleColor: UIColor = Colors.appGreen.color
        static let unSelectedTitleColor: UIColor = Colors.appGray.color
        
        static let registerBikeTabImage: UIImage = UIImage(systemName: "plus.circle")!.withRenderingMode(.alwaysTemplate)
        static let registerBikeTitle: String = L10n.TabBarItems.registerBike
        static let mapTabImage: UIImage = UIImage(systemName: "map.circle")!.withRenderingMode(.alwaysTemplate)
        static let mapTitle: String = L10n.TabBarItems.map
        static let myBikeTabImage: UIImage = UIImage(systemName: "bicycle.circle")!.withRenderingMode(.alwaysTemplate)
        static let myBikeTitle: String = L10n.TabBarItems.myBike
    }
}

// MARK: - RouterInterface

protocol MainRouterInterface: RouterInterface {
    func getViewControllers() -> [UINavigationController]
}

// MARK: - MainRouter

final class MainRouter {
    private weak var presenter: MainPresenter?
    private var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    static func createModule(tabType: TabType = .map) -> UIViewController {

        let interactor = MainInteractor()
        let view = MainViewController()
        let navCon = UINavigationController(rootViewController: view)
        navCon.modalPresentationStyle = .fullScreen
        let router = MainRouter(navigationController: navCon)
        let presenter = MainPresenter(router: router, interactor: interactor, view: view, tabType: tabType)
        router.presenter = presenter
        view.presenter = presenter
        interactor.output = presenter
        presenter.setupViewControllers()
        return navCon
    }
}

// MARK: - MainRouterInterface

extension MainRouter: MainRouterInterface {
    func getViewControllers() -> [UINavigationController] {
        let selectedTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Constant.TabBarItem.selectedTitleColor,
            NSAttributedString.Key.font: Constant.TabBarItem.titleFont
        ]
        
        let unselectedTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Constant.TabBarItem.unSelectedTitleColor,
            NSAttributedString.Key.font: Constant.TabBarItem.titleFont
        ]

        let registerBikeView = RegisterBikeRouter.createModule()
        registerBikeView.tabBarItem.title = Constant.TabBarItem.registerBikeTitle
        registerBikeView.tabBarItem?.image = Constant.TabBarItem.registerBikeTabImage
        registerBikeView.tabBarItem?.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        registerBikeView.tabBarItem?.setTitleTextAttributes(unselectedTitleTextAttributes, for: .normal)
        
        let mapView = MapRouter.createModule()
        mapView.tabBarItem.title = Constant.TabBarItem.mapTitle
        mapView.tabBarItem?.image = Constant.TabBarItem.mapTabImage
        mapView.tabBarItem?.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        mapView.tabBarItem?.setTitleTextAttributes(unselectedTitleTextAttributes, for: .normal)
        
        let myBikeView = MyBikeRouter.createModule()
        myBikeView.tabBarItem.title = Constant.TabBarItem.myBikeTitle
        myBikeView.tabBarItem?.image = Constant.TabBarItem.myBikeTabImage
        myBikeView.tabBarItem?.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        myBikeView.tabBarItem?.setTitleTextAttributes(unselectedTitleTextAttributes, for: .normal)
        
        return [
            registerBikeView,
            mapView,
            myBikeView
        ]
    }
}


