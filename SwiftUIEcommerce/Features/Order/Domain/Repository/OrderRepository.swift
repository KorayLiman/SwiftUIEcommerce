//
//  PlaceOrderRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 3.08.2025.
//

protocol IOrderRepository {
    func getAddressList() async -> BaseResponse<[AddressResponseModel]>
    func placeOrder(request: PlaceOrderRequestModel) async -> BaseResponse<NullData>
    func addAddress(request: AddAddressRequestModel) async -> BaseResponse<NullData>
    func getOrders() async -> BaseResponse<[OrderResponseModel]>
    func cancelOrder(request: CancelOrderRequestModel) async -> BaseResponse<NullData>
    func deleteAddress(id: Int) async -> BaseResponse<NullData>
}

final class OrderRepository: IOrderRepository {
    init(orderRemoteDS: IOrderRemoteDS) {
        self.orderRemoteDS = orderRemoteDS
    }
    
    private let orderRemoteDS: IOrderRemoteDS
    
    func getAddressList() async -> BaseResponse<[AddressResponseModel]> {
        await orderRemoteDS.getAddressList()
    }
    
    func placeOrder(request: PlaceOrderRequestModel) async -> BaseResponse<NullData> {
        await orderRemoteDS.placeOrder(request: request)
    }
    
    func addAddress(request: AddAddressRequestModel) async -> BaseResponse<NullData> {
        await orderRemoteDS.addAddress(request: request)
    }

    func getOrders() async -> BaseResponse<[OrderResponseModel]> {
        await orderRemoteDS.getOrders()
    }
    
    func cancelOrder(request: CancelOrderRequestModel) async -> BaseResponse<NullData> {
        await orderRemoteDS.cancelOrder(request: request)
    }
    
    func deleteAddress(id: Int) async -> BaseResponse<NullData> {
        await orderRemoteDS.deleteAddress(id: id)
    }
}
