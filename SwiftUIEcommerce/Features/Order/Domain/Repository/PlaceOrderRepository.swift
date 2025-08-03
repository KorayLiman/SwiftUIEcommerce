//
//  PlaceOrderRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 3.08.2025.
//


protocol IPlaceOrderRepository {
    func getAddressList() async -> BaseResponse<[AddressResponseModel]>
}


final class PlaceOrderRepository: IPlaceOrderRepository {
    
    init(placeOrderRemoteDS: IPlaceOrderRemoteDS) {
        self.placeOrderRemoteDS = placeOrderRemoteDS
    }
    
    private let placeOrderRemoteDS: IPlaceOrderRemoteDS
    
    func getAddressList() async -> BaseResponse<[AddressResponseModel]> {
        await placeOrderRemoteDS.getAddressList()
    }
    
}

