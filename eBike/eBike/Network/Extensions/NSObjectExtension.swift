//
//  NSObjectExtension.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation

extension NSObject {
    public var className: String {
        return type(of: self).className
    }
    
    public static var className: String {
        return String(describing: self)
    }
}
