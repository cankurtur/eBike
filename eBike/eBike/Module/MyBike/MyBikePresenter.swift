//
//  MyBikePresenter.swift
//  eBike
//
//  Created by Can Kurtur on 24.04.2023.
//

import Foundation

// MARK: - PresenterInterface

protocol MyBikePresenterInterface: PresenterInterface {
    func addNewBikeButtonTapped()
    func MyBikeButtonTapped()
}

// MARK: - MyBikePresenter

final class MyBikePresenter {
    private let router: MyBikeRouterInterface
    private let interactor: MyBikeInteractorInterface
    private weak var view: MyBikeViewInterface?
    private let locationManager: LocationManager
    private let swiftMessagesManager: SwiftMessagesManager
    private let notificationCenter: NotificationCenterProtocol?
    
    init(router: MyBikeRouterInterface,
         interactor: MyBikeInteractorInterface,
         view: MyBikeViewInterface?,
         locationManager: LocationManager = LocationManager.shared,
         swiftMessagesManager: SwiftMessagesManager = SwiftMessagesManager.shared,
         notificationCenter: NotificationCenterProtocol = NotificationCenter.default) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.locationManager = locationManager
        self.swiftMessagesManager = swiftMessagesManager
        self.notificationCenter = notificationCenter
    }
    
    deinit {
        notificationCenter?.removeWith(self)
    }
}

// MARK: - MyBikePresenterInterface

extension MyBikePresenter: MyBikePresenterInterface {
    func viewDidLoad() {
        prepareUI()
    }
    
    func viewWillAppear() {
        prepareUI()
    }
    
    func addNewBikeButtonTapped() {
        router.navigateToMap()
    }
    
    func MyBikeButtonTapped() {
        guard let bikeInfo = createUpdateBikeInfo() else { return }
        
        interactor.updateBike(with: bikeInfo)
    }
}

// MARK: - MyBikeInteractorOutput

extension MyBikePresenter: MyBikeInteractorOutput {
    func onMyBikeReceived(_ result: Result<EmptyResponse, APIClientError>) {
        switch result {
        case .success:
            UserDefaultsConfig.currentBike = nil
            UserDefaultsConfig.isOnTrip = false
            notificationCenter?.post(with: .shouldUpdateMap, object: nil)

            let appPopupModel = AppPopupViewModel(
                title: L10n.AppPopupView.tripIsComplete,
                description: L10n.AppPopupView.successfullyReturned,
                buttonTitle:  L10n.AppPopupView.cool) { [weak self] in
                    guard let self = self else { return }
                    
                    self.swiftMessagesManager.hide()
                    self.router.navigateToMap()
                }
            
            swiftMessagesManager.showForever(with: appPopupModel)
            view?.updateUIAfterMyBike()
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
            
            interactor.MyBike(with: intBikeID)
        case .failure(let error):
            break
        }
    }
}

// MARK: - Helper

private extension MyBikePresenter {
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
