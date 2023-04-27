//
//  PresenterInterface.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation

public protocol PresenterInterface: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func viewWillEnterForeground()
    func viewDidLayoutSubviews()
}

public extension PresenterInterface {
    func viewDidLoad() { }
    func viewWillAppear() { }
    func viewDidAppear() { }
    func viewWillDisappear() { }
    func viewDidDisappear() { }
    func viewWillEnterForeground() { }
    func viewDidLayoutSubviews() { }
}
