//
//  UserDefaultsConfig.swift
//  eBike
//
//  Created by Can Kurtur on 24.04.2023.
//


import Foundation

struct UserDefaultsConfig {
    @UserDefaultProperty(key: "currentBike", defaultValue: nil)
    static var currentBike: BikeAnnotation?
    
    @UserDefaultProperty(key: "isOnTrip", defaultValue: false)
    static var isOnTrip: Bool
}

@propertyWrapper
struct UserDefaultProperty<Value: Codable> {
    let key: String
    let defaultValue: Value
    var storage: UserDefaults = .standard
    
    struct Wrapper<Value>: Codable where Value: Codable {
        let wrapped: Value
    }
    
    var wrappedValue: Value {
        get {
            guard let data = storage.object(forKey: key) as? Data else {
                return defaultValue
            }
            
            let value = try? JSONDecoder().decode(Wrapper<Value>.self, from: data)
            return value?.wrapped ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(Wrapper(wrapped: newValue))
            storage.set(data, forKey: key)
        }
    }
}

extension UserDefaultProperty where Value: ExpressibleByNilLiteral {
    init(key: String, storage: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, storage: storage)
    }
}
