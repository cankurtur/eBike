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
    private let alertManager: AlertManager
    
    init(sessionManager: Session = .init(configuration: URLSessionConfiguration.default),
         monitorManager: MonitorManager = MonitorManager.shared,
         alertManager: AlertManager = AlertManager.shared) {
        self.sessionManager = sessionManager
        self.monitorManager = monitorManager
        self.alertManager = alertManager
    }

    
    private var possibleEmptyBodyResponseCodes: Set<Int> {
        var defaultSet = DataResponseSerializer.defaultEmptyResponseCodes
        defaultSet.insert(200)
        defaultSet.insert(201)
        return defaultSet
    }
    
    public func request<T>(endpoint: EndpointItem, type: T.Type, networkCompletion: @escaping NetworkCompletion<T>, networkFailureCompletion: NetworkFailureCompletion? = nil) {
        
        guard monitorManager.isReachable else {
            DispatchQueue.main.async { [weak self] in
                self?.alertManager.showAlertFromTopViewController(
                    message:  L10n.General.checkInternetConnection,
                    title: L10n.General.areYouOffline,
                    firstButtonTitle: L10n.General.tryAgain) { [weak self] in
                        guard let self = self else { return }
                        
                        if networkFailureCompletion != nil {
                            networkFailureCompletion?()
                        } else {
                            self.request(endpoint: endpoint, type: type.self, networkCompletion: networkCompletion)
                        }
                    }
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
                    do {
                        guard let data = response.data else {
                            networkCompletion(.failure(.networkError))
                            return
                        }
                        let clientError = try JSONDecoder().decode(ClientError.self, from: data)
                        clientError.statusCode = error.asAFError?.responseCode
                        networkCompletion(.failure(.handledError(error: clientError)))
                    } catch {
                        let decodingError = APIClientError.decoding(error: error as? DecodingError)
                        networkCompletion(.failure(decodingError))
                    }
                }
            }
        })
    }
}