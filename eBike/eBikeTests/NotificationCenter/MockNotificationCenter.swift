//
//  MockNotificationCenter.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

import Foundation
@testable import eBike

final class MockNotificationCenter: NotificationCenterProtocol {
   
    var observer: Any?
    var selector: Selector?
    var name: NSNotification.Name?
    var object: Any?
    var userInfo: [AnyHashable: Any]?
    
    func add(observer: Any, selector: Selector, name: NSNotification.Name, object: Any?) {
        self.observer = observer
        self.selector = selector
        self.name = name
        self.object = object
    }
    
    func removeWith(_ observer: Any) {
        self.observer = observer
        self.name = nil
        self.object = nil
    }
    
    func removeObserverWithName(with observer: Any, name: Notification.Name, object: Any?) {
        self.observer = observer
        self.name = name
        self.object = object
    }
    
    func post(with name: NSNotification.Name, object: Any?) {
        self.name = name
        self.object = object
        self.userInfo = nil
    }
    
    func post(with name: NSNotification.Name, object: Any?, userInfo: [AnyHashable: Any]?) {
        self.name = name
        self.object = object
        self.userInfo = userInfo
    }
}
