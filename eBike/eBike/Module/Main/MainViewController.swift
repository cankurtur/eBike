//
//  MainViewController.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import UIKit

// MARK: - Constant

private enum Constant {
    static let backgroundColor: UIColor = .white
    
    enum TabBar {
        static let tintColor: UIColor = Colors.appGreen.color
        static let unselectedItemTintColor: UIColor = Colors.appGray.color
    }
}

// MARK: - ViewInterface

protocol MainViewInterface: ViewInterface {
    func prepareUI()
    func display(_ viewControllers: [UIViewController], with currentIndex: Int)
}

// MARK: - MainViewController

final class MainViewController: UITabBarController {

    var presenter: MainPresenterInterface! {
        didSet {
            presenter.viewDidLoad()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - MainViewInterface

extension MainViewController: MainViewInterface {
    func prepareUI() {
        view.backgroundColor = Constant.backgroundColor
        prepareTabBar()
    }
    
    func display(_ viewControllers: [UIViewController], with currentIndex: Int) {
        self.viewControllers = viewControllers
        selectedViewController = viewControllers[currentIndex]
    }
}

// MARK: - Prepares

private extension MainViewController {
    func prepareTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = Constant.TabBar.tintColor
        tabBar.unselectedItemTintColor = Constant.TabBar.unselectedItemTintColor
    }
}

