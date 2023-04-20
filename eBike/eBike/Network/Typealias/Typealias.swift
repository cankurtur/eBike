//
//  Typealias.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation
import Alamofire

public typealias NetworkCompletion<T> = (Result<T, APIClientError>) -> Void where T: Decodable
public typealias NetworkFailureCompletion = (() -> Void)
public typealias HTTPMethod = Alamofire.HTTPMethod
public typealias HTTPHeaders = Alamofire.HTTPHeaders
public typealias HTTPHeader = Alamofire.HTTPHeader
