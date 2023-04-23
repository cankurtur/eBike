//
//  Config.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation

class Config: NSObject {
    static let sharedInstance = Config()
    
    private var configs: NSDictionary!
    
    override private init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Config")!
        let path = Bundle.main.path(forResource: "Config", ofType: "plist")!
        configs = (NSDictionary(contentsOfFile: path)!.object(forKey: currentConfiguration) as! NSDictionary)
    }
}

extension Config {
    var eBikeBaseUrl: String {
        return configs.object(forKey: "eBikeBaseUrl") as! String
    }
    
    var regionRadius: Double {
        return configs.object(forKey: "regionRadius") as! Double
    }
    
    var colorSet: [String] {
        return configs.object(forKey: "colorSet") as! [String]
    }
    
    var colorsWithHex: [String: String] {
        return configs.object(forKey: "colorsWithHex") as! [String: String]
    }
}
