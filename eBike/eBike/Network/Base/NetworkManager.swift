//
//  NetworkManager.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation
import Alamofire

final public class NetworkManager<EndpointItem: Endpoint>: NetworkProtocol {
    private let sessionManager: Session
    private let monitorManager: MonitorManager
    private let swiftMessagesManager: SwiftMessagesManager
    
    init(sessionManager: Session = .init(configuration: URLSessionConfiguration.default),
         monitorManager: MonitorManager = MonitorManager.shared,
         swiftMessagesManager: SwiftMessagesManager = SwiftMessagesManager.shared) {
        self.sessionManager = sessionManager
        self.monitorManager = monitorManager
        self.swiftMessagesManager = swiftMessagesManager
    }

    
    private var possibleEmptyBodyResponseCodes: Set<Int> {
        var defaultSet = DataResponseSerializer.defaultEmptyResponseCodes
        defaultSet.insert(200)
        defaultSet.insert(201)
        return defaultSet
    }
    
    public func request<T>(endpoint: EndpointItem, type: T.Type, networkCompletion: @escaping NetworkCompletion<T>, networkFailureCompletion: NetworkFailureCompletion? = nil) {
        
        guard monitorManager.isReachable else {
            
            let viewModel = AppPopupViewModel(title: L10n.General.areYouOffline,
                                              description: L10n.General.checkInternetConnection,
                                              buttonTitle: L10n.General.tryAgain) { [weak self] in
                guard let self = self else { return }
                
                self.swiftMessagesManager.hide()
                
                if networkFailureCompletion != nil {
                    networkFailureCompletion?()
                } else {
                    self.request(endpoint: endpoint, type: type.self, networkCompletion: networkCompletion)
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                self.swiftMessagesManager.showForever(with: viewModel)
            }
            networkCompletion(.failure(.networkError))
            
            return
        }
        
        self.sessionManager.request(endpoint.url,
                                    method: endpoint.method,
                                    parameters: endpoint.params,
                                    encoding: endpoint.method.encoding,
                                    headers: endpoint.headers
        )
        .validate()
        .response(responseSerializer: DataResponseSerializer(emptyResponseCodes: self.possibleEmptyBodyResponseCodes), completionHandler: { (response) in
            switch response.result {
            case .success(let data):
                guard !data.isEmpty else {
                    networkCompletion(.success(EmptyResponse() as! T))
                    return
                }
                
                do {
                    let decodedObject = try JSONDecoder().decode(type, from: data)
                    networkCompletion(.success(decodedObject))
                } catch {
                    let decodingError = APIClientError.decoding(error: error as? DecodingError)
                    networkCompletion(.failure(decodingError))
                }
                
            case.failure(let error):
                if (error as NSError).code == NSURLErrorTimedOut {
                    networkCompletion(.failure(.timeout))
                } else {
                    guard let data = response.data else {
                        networkCompletion(.failure(.networkError))
                        return
                    }
                    let handledError = String(data: data, encoding: String.Encoding.utf8)
                    networkCompletion(.failure(.handledError(error: handledError)))
                }
            }
        })
    }
}
