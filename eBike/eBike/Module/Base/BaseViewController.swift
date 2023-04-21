//
//  BaseViewController.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import UIKit

class BaseViewController: UIViewController {

    var screenName: String {
        return "#" + self.className
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("initialized: ", screenName)
    }
    
    deinit {
        print("deinitialized:", screenName)
    }
}
