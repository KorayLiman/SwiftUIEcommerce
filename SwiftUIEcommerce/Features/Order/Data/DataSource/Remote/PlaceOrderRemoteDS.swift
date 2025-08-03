//
//  PlaceOrderRemoteDS.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 3.08.2025.
//

protocol IPlaceOrderRemoteDS {
    func getAddressList() async -> BaseResponse<[AddressResponseModel]>
    func placeOrder(request: PlaceOrderRequestModel) async -> BaseResponse<NullData>
}

final class PlaceOrderRemoteDS: BaseRemoteDS, IPlaceOrderRemoteDS {
    func getAddressList() async -> BaseResponse<[AddressResponseModel]> {
        await networkManager.request([AddressResponseModel].self, path: .address, method: .get)
    }
    
    func placeOrder(request: PlaceOrderRequestModel) async -> BaseResponse<NullData> {
        await networkManager.request(path: .order, method: .post, parameters: request)
    }
}
