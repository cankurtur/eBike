//
//  MyBikeInteractor.swift
//  eBikeTests
//
//  Created by Can Kurtur on 27.04.2023.
//

@testable import eBike

final class MockMyBikeInteractor: MyBikeInteractorInterface {

    var isUpdateBikeCalled: Bool = false
    var isReturnBikeCalled: Bool = false
   
    weak var output: MyBikeInteractorOutput?
    
    func updateBike(with updateBikeInfo: UpdateBikeInfo) {
        isUpdateBikeCalled = true
    }
    
    func returnBike(with bikeID: Int) {
        isReturnBikeCalled = true
    }

}
