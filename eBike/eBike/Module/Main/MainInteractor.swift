//
//  MainInteractor.swift
//  eBike
//
//  Created by Can Kurtur on 21.04.2023.
//

import Foundation

// MARK: - InteractorInterface

protocol MainInteractorInterface: InteractorInterface { }

// MARK: - MainInteractorOutput

protocol MainInteractorOutput: AnyObject { }

// MARK: - MainInteractor

final class MainInteractor {
    weak var output: MainInteractorOutput?
}

// MARK: - MainInteractorInterface
extension MainInteractor: MainInteractorInterface { }
