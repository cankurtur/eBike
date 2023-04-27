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

final class RegisterBikePresenter: BasePresenter {
    private let router: RegisterBikeRouterInterface
    private let interactor: RegisterBikeInteractorInterface
    private weak var view: RegisterBikeViewInterface?
    private let config: Config
   
    init(router: RegisterBikeRouterInterface,
         interactor: RegisterBikeInteractorInterface,
         view: RegisterBikeViewInterface?,
         config: Config = Config.sharedInstance) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.config = config
        super.init(router: router, interactor: interactor, view: view)
        
    }
    
    deinit {
        notificationCenter?.removeWith(self)
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
            view?.showPopup(title: L10n.AppPopupView.error, message: L10n.AppPopupView.nameErrorMessage)
            return
        }

        guard let pin = pin, !pin.isBlank else {
            view?.showPopup(title: L10n.AppPopupView.error, message: L10n.AppPopupView.pinErrorMessage)
            return
        }

        guard let color = color, !color.isBlank else {
            view?.showPopup(title: L10n.AppPopupView.error, message: L10n.AppPopupView.colorErrorMessage)
            return
        }
        
        guard hasLocationPermission else {
            handleLocationPermission()
            return
        }
        
        guard let location = locationManager.getCurrentLocation() else {
            return
        }

        let request = CreateNewBikeRequest(
            name: name,
            pin: pin,
            color: config.colorsWithHex[color] ?? "",
            location: Location(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        )
        view?.showHUD()
        interactor.createNewBike(with: request)
    }
    
    func textFieldDidEndEditing(name: String?, pin: String?, color: String?) -> Bool {
        return !(!(name == "") && !(pin == "") && !(color == ""))
    }
}

// MARK: - RegisterBikeInteractorOutput

extension RegisterBikePresenter: RegisterBikeInteractorOutput {
    func onGetCreateNewBikeReceived(_ result: Result<EmptyResponse, APIClientError>) {
        view?.dismissHUD()
        switch result {
        case .success:
            notificationCenter?.post(with: .shouldUpdateMap, object: nil)
            view?.updateUIAfterRegister()
            view?.showPopup(title: L10n.AppPopupView.success,
                            message: L10n.AppPopupView.youHaveRegister,
                            buttonTitle: L10n.AppPopupView.cool)
        case .failure(let error):
            view?.showPopup(error: error, buttonAction: nil)
            break
        }
    }
}
