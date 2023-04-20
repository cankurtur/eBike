//
//  Errors.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation

public protocol APIError: Codable {
    var message: String? { get }
    var statusCode: Int? { get set }
}

public class ClientError: APIError {
    public var message: String?
    public var statusCode: Int?
}

public enum APIClientError: Error {
    case handledError(error: APIError)
    case networkError
    case decoding(error: DecodingError?)
    case timeout
    // This is only for unit testing purposes
    case localJSONDecoder(error: String)
    
    public var message: String {
        switch self {
        case .handledError(let error):
            return error.message ?? ""
        case .decoding:
            return "Decoding Error"
        case .networkError:
            return "Connection Error"
        case .timeout:
            return "Timeout"
        case .localJSONDecoder(let error):
            return "localJSONDecoder Error: \(error)"
        }
    }
    
    public var statusCode: Int {
        switch self {
        case .handledError(let error):
            return error.statusCode ?? 0
        case .networkError:
            return NSURLErrorCannotDecodeRawData
        case .decoding:
            return NSURLErrorTimedOut
        case .timeout:
            return 400
        case .localJSONDecoder:
            return 0
        }
    }
}
