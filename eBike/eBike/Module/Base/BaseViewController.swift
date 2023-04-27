//
//  BaseViewController.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import UIKit

// MARK: - BaseViewController

class BaseViewController: UIViewController {

    var screenName: String {
        return "#" + self.className
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        hideKeyboardWhenTappedAround()
        print("initialized: ", screenName)
    }
    
    deinit {
        print("deinitialized:", screenName)
    }
}

// MARK: - Helper

private extension BaseViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

// MARK: - Actions

@objc
private extension BaseViewController {
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
