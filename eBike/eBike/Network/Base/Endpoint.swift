//
//  Endpoint.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation

public protocol Endpoint: CustomStringConvertible {
    var baseUrl: EBikeBaseUrl { get }
    var path: String { get }
    var params: [String: Any]? { get }
    var headers: HTTPHeaders? { get }
    var url: String { get }
    var method: HTTPMethod { get }
}

public extension Endpoint {
    var baseUrl: EBikeBaseUrl {
        return .eBikeBaseUrl
    }
    
    var params: [String: Any]? {
        return nil
    }
    
    var url: String {
        switch baseUrl {
        case .eBikeBaseUrl:
            let eBikeBaseUrl = Config.sharedInstance.eBikeBaseUrl()
            return "\(eBikeBaseUrl)\(path)"
        }
    }
    
    var headers: HTTPHeaders? {
        switch baseUrl {
        case .eBikeBaseUrl:
            let headers = baseHeaders
            return headers
        }
    }
    
    var description: String {
        var descriptionString = String()
        descriptionString.append(contentsOf: "\nURL: [\(method.rawValue)] \(url)")
        descriptionString.append(contentsOf: "\nHEADERS: \(headers ?? HTTPHeaders())")
        descriptionString.append(contentsOf: "\nPARAMETERS: \(String(describing: params ?? [:]))")
        return descriptionString
    }
    
    var baseHeaders: HTTPHeaders? {
        var headersDict = [String: String]()
        headersDict["accept"] = "application/json"

        return HTTPHeaders(headersDict)
    }
}
