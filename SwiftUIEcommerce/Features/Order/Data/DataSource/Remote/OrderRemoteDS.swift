//
//  PlaceOrderRemoteDS.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 3.08.2025.
//

protocol IOrderRemoteDS {
    func getAddressList() async -> BaseResponse<[AddressResponseModel]>
    func placeOrder(request: PlaceOrderRequestModel) async -> BaseResponse<NullData>
    func addAddress(request: AddAddressRequestModel) async -> BaseResponse<NullData>
    func getOrders() async -> BaseResponse<[OrderResponseModel]>
    func cancelOrder(request: CancelOrderRequestModel) async -> BaseResponse<NullData>
    func deleteAddress(id: Int) async -> BaseResponse<NullData>
}

final class OrderRemoteDS: BaseRemoteDS, IOrderRemoteDS {
    func getAddressList() async -> BaseResponse<[AddressResponseModel]> {
        await networkManager.request([AddressResponseModel].self, path: .address, method: .get)
    }

    func placeOrder(request: PlaceOrderRequestModel) async -> BaseResponse<NullData> {
        await networkManager.request(path: .order, method: .post, parameters: request)
    }

    func addAddress(request: AddAddressRequestModel) async -> BaseResponse<NullData> {
        await networkManager.request(path: .address, method: .post, parameters: request)
    }

    func getOrders() async -> BaseResponse<[OrderResponseModel]> {
        await networkManager.request([OrderResponseModel].self, path: .order, method: .get)
    }

    func cancelOrder(request: CancelOrderRequestModel) async -> BaseResponse<NullData> {
        await networkManager.request(path: .updateOrderStatus, method: .put, parameters: request)
    }

    func deleteAddress(id: Int) async -> BaseResponse<NullData> {
        await networkManager.request(path: .deleteAddress(id: id), method: .delete)
    }
}
