//
//  UserDefaultProperty.swift
//  eBike
//
//  Created by Can Kurtur on 24.04.2023.
//

import Foundation

@propertyWrapper
struct UserDefaultProperty<Value: Codable> {
    let key: UserDefaults.Key
    let defaultValue: Value
    var storage: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            guard let data = storage.object(forKey: key.rawValue) as? Data else {
                return defaultValue
            }
            let value = try? JSONDecoder().decode(Value.self, from: data)
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            storage.set(data, forKey: key.rawValue)
            storage.synchronize()
        }
    }
    
}

extension UserDefaultProperty where Value: ExpressibleByNilLiteral {
    init(key: UserDefaults.Key, storage: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, storage: storage)
    }
}


