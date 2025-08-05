//
//  PlaceOrderRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 3.08.2025.
//

protocol IPlaceOrderRepository {
    func getAddressList() async -> BaseResponse<[AddressResponseModel]>
    func placeOrder(request: PlaceOrderRequestModel) async -> BaseResponse<NullData>
    func addAddress(request: AddAddressRequestModel) async -> BaseResponse<NullData>
}

final class PlaceOrderRepository: IPlaceOrderRepository {
    init(placeOrderRemoteDS: IPlaceOrderRemoteDS) {
        self.placeOrderRemoteDS = placeOrderRemoteDS
    }
    
    private let placeOrderRemoteDS: IPlaceOrderRemoteDS
    
    func getAddressList() async -> BaseResponse<[AddressResponseModel]> {
        await placeOrderRemoteDS.getAddressList()
    }
    
    func placeOrder(request: PlaceOrderRequestModel) async -> BaseResponse<NullData> {
        await placeOrderRemoteDS.placeOrder(request: request)
    }
    
    func addAddress(request: AddAddressRequestModel) async -> BaseResponse<NullData> {
        await placeOrderRemoteDS.addAddress(request: request)
    }
}
