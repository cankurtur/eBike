//
//  NetworkProtocol.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation

public protocol NetworkProtocol {
    associatedtype EndpointItem: Endpoint
    
    func request<T: Decodable>(
        endpoint: EndpointItem,
        type: T.Type,
        networkCompletion: @escaping NetworkCompletion<T>,
        networkFailureCompletion: NetworkFailureCompletion?
    )
}
