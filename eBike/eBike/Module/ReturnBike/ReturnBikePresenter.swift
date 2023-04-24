//
//  ReturnBikePresenter.swift
//  eBike
//
//  Created by Can Kurtur on 24.04.2023.
//

import Foundation

// MARK: - PresenterInterface

protocol ReturnBikePresenterInterface: PresenterInterface {
    func addNewBikeButtonTapped()
    func returnBikeButtonTapped()
}

// MARK: - ReturnBikePresenter

final class ReturnBikePresenter {
    private let router: ReturnBikeRouterInterface
    private let interactor: ReturnBikeInteractorInterface
    private weak var view: ReturnBikeViewInterface?
    private let locationManager: LocationManager
    private let swiftMessagesManager: SwiftMessagesManager
    
    init(router: ReturnBikeRouterInterface,
         interactor: ReturnBikeInteractorInterface,
         view: ReturnBikeViewInterface?,
         locationManager: LocationManager = LocationManager.shared,
         swiftMessagesManager: SwiftMessagesManager = SwiftMessagesManager.shared) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.locationManager = locationManager
        self.swiftMessagesManager = swiftMessagesManager
    }
}

// MARK: - ReturnBikePresenterInterface

extension ReturnBikePresenter: ReturnBikePresenterInterface {
    func viewDidLoad() {
        prepareUI()
    }
    
    func viewWillAppear() {
        prepareUI()
    }
    
    func addNewBikeButtonTapped() {
        router.navigateToMap()
    }
    
    func returnBikeButtonTapped() {
        guard let bikeInfo = createUpdateBikeInfo() else { return }
        
        interactor.updateBike(with: bikeInfo)
    }
}

// MARK: - ReturnBikeInteractorOutput

extension ReturnBikePresenter: ReturnBikeInteractorOutput {
    func onReturnBikeReceived(_ result: Result<EmptyResponse, APIClientError>) {
        switch result {
        case .success:
            UserDefaultsConfig.currentBike = nil
            UserDefaultsConfig.isOnTrip = false
            let appPopupModel = AppPopupViewModel(
                title: L10n.AppPopupView.tripIsComplete,
                description: L10n.AppPopupView.successfullyReturned,
                buttonTitle:  L10n.AppPopupView.cool) { [weak self] in
                    guard let self = self else { return }
                    
                    self.swiftMessagesManager.hide()
                    self.router.navigateToMap()
                }
            
            swiftMessagesManager.showForever(with: appPopupModel)
            view?.updateUIAfterReturnBike()

        case .failure(let error):
            break
        }
    }
    
    func onUpdateBikeReceived(_ result: Result<EmptyResponse, APIClientError>) {
        switch result {
        case .success:
            guard let currentBikeID = UserDefaultsConfig.currentBike?.id,
                  let intBikeID = Int(currentBikeID) else {
                return
            }
            
            interactor.returnBike(with: intBikeID)
        case .failure(let error):
            break
        }
    }
}

// MARK: - Helper

private extension ReturnBikePresenter {
    func prepareUI() {
        view?.prepareUI(
            isOnTrip: UserDefaultsConfig.isOnTrip,
            pinText: UserDefaultsConfig.currentBike?.pin ?? "",
            bikeColorHex: UserDefaultsConfig.currentBike?.hexColor ?? ""
        )
    }
    
    func createUpdateBikeInfo() -> UpdateBikeInfo? {
        guard let currentBike = UserDefaultsConfig.currentBike,
              let intBikeID = Int(currentBike.id),
              let currentLocation = locationManager.getCurrentLocation() else { return nil }
        
        let location = Location(
            latitude: currentLocation.coordinate.latitude,
            longitude: currentLocation.coordinate.longitude
        )
        
        let request = UpdateBikeRequest(
            name: currentBike.name,
            color: currentBike.hexColor,
            pin: currentBike.pin,
            location: location
        )
        
        return UpdateBikeInfo(id: intBikeID, request: request)
    }
}
