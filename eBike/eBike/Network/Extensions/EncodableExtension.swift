//
//  EncodableExtension.swift
//  eBike
//
//  Created by Can Kurtur on 22.04.2023.
//

import Foundation

public extension Encodable {
    func parameters() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
            let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return nil
        }
        return dictionary
    }
}
