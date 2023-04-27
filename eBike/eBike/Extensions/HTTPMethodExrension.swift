//
//  HTTPMethodExrension.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation
import Alamofire

public extension HTTPMethod {
    var encoding: ParameterEncoding {
        switch self {
        case . get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
