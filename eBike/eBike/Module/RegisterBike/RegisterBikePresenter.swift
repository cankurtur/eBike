//
//  RegisterBikePresenter.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import Foundation

// MARK: - Constant

private enum Constant {
    static let numberOfComponents: Int = 1
}

// MARK: - PresenterInterface

protocol RegisterBikePresenterInterface: PresenterInterface {
    func numberOfComponents() -> Int
    func numberOfRowsInComponent(_ component: Int) -> Int
    func titleForRow(at row: Int) -> String?
    func didSelectRow(at row: Int) -> String
    func registerButtonTapped(name: String?, pin: String?, color: String?)
    func textFieldDidEndEditing(name: String?, pin: String?, color: String?) -> Bool
}

// MARK: - RegisterBikePresenter

final class RegisterBikePresenter {
    private let router: RegisterBikeRouterInterface
    private let interactor: RegisterBikeInteractorInterface
    private weak var view: RegisterBikeViewInterface?
    private let config: Config
    private let locationManager: LocationManager
   
    init(router: RegisterBikeRouterInterface,
         interactor: RegisterBikeInteractorInterface,
         view: RegisterBikeViewInterface?,
         config: Config = Config.sharedInstance,
         locationManager: LocationManager = LocationManager.shared) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.config = config
        self.locationManager = locationManager
    }
}

// MARK: - RegisterBikePresenterInterface

extension RegisterBikePresenter: RegisterBikePresenterInterface {
    func viewDidLoad() {
        view?.prepareUI()
    }
    
    func numberOfComponents() -> Int {
        return Constant.numberOfComponents
    }
    
    func numberOfRowsInComponent(_ component: Int) -> Int {
        return config.colorSet.count
    }
    
    func titleForRow(at row: Int) -> String? {
        return config.colorSet[row]
    }
    
    func didSelectRow(at row: Int) -> String {
        return config.colorSet[row]
    }
    
    func registerButtonTapped(name: String?, pin: String?, color: String?) {
        guard let name = name, !name.isBlank else {
            return
        }

        guard let pin = pin, !pin.isBlank else {
            return
        }

        guard let color = color, !color.isBlank else {
            return
        }
        
        guard let location = locationManager.getCurrentLocation() else {
            return
        }

        let request = CreateNewBikeRequest(
            name: name,
            pin: pin,
            color: color,
            location: Location(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        )
        
        interactor.createNewBike(with: request)
    }
    
    func textFieldDidEndEditing(name: String?, pin: String?, color: String?) -> Bool {
        return !(!(name == "") && !(pin == "") && !(color == ""))
    }
}

// MARK: - RegisterBikeInteractorOutput

extension RegisterBikePresenter: RegisterBikeInteractorOutput {
    func onGetCreateNewBikeReceived(_ result: Result<EmptyResponse, APIClientError>) {
        switch result {
        case .success:
            view?.updateUIAfterRegister()
        case .failure(let error):
            break
        }
    }
}
