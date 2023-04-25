//
//  RentBikePresenter.swift
//  eBike
//
//  Created by Can Kurtur on 23.04.2023.
//

import Foundation

// MARK: - RentBikePresenterDelegate

protocol RentBikePresenterDelegate: AnyObject {
    func shouldDismissRentView()
}

// MARK: - PresenterInterface

protocol RentBikePresenterInterface: PresenterInterface {
    func rentButtonTapped()
    func iGotItButtonTapped()
}

// MARK: - RentBikePresenter

final class RentBikePresenter {
    private let router: RentBikeRouterInterface
    private let interactor: RentBikeInteractorInterface
    private weak var view: RentBikeViewInterface?
    private let annotation: BikeAnnotation
    private weak var delegate: RentBikePresenterDelegate?
    
    init(router: RentBikeRouterInterface,
         interactor: RentBikeInteractorInterface,
         view: RentBikeViewInterface?,
         annotation: BikeAnnotation,
         delegate: RentBikePresenterDelegate?) {
        self.router = router
        self.interactor = interactor
        self.view = view
        self.annotation = annotation
        self.delegate = delegate
    }
}

// MARK: - RentBikePresenterInterface

extension RentBikePresenter: RentBikePresenterInterface {
    func viewDidLoad() {
        view?.prepareUI(
            nameText: annotation.name,
            bikeHexString: annotation.hexColor,
            pinText: annotation.pin
        )
    }
    
    func rentButtonTapped() {
        guard !UserDefaultsConfig.isOnTrip else { return }
        
        guard let id = Int(annotation.id) else { return }
        
        interactor.rentBike(with: id)
    }
    
    func iGotItButtonTapped() {
        delegate?.shouldDismissRentView()
        router.dismiss()
    }
}

// MARK: - RentBikeInteractorOutput

extension RentBikePresenter: RentBikeInteractorOutput {
    func onRentBikeReceived(_ result: Result<EmptyResponse, APIClientError>) {
        switch result {
        case .success:
            UserDefaultsConfig.currentBike = annotation
            UserDefaultsConfig.isOnTrip = true
            view?.updateUIAfterRentBike()
        case .failure(let error):
            view?.showPopup(error: error, buttonAction: { [weak self] in
                guard let self = self else { return }
                
                self.delegate?.shouldDismissRentView()
                self.router.dismiss()
            })
        }
    }
}

