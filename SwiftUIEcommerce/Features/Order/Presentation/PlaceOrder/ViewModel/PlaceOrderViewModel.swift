//
//  PlaceOrderViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 2.08.2025.
//

import Observation

@MainActor
@Observable
final class PlaceOrderViewModel {
    init(orderRepository: IOrderRepository? = nil, rootNavigator: Navigator? = nil, cartRepository: ICartRepository? = nil) {
        self.orderRepository = orderRepository ?? DIContainer.shared.synchronizedResolver.resolve(IOrderRepository.self)!
        
        self.rootNavigator = rootNavigator ?? DIContainer.shared.synchronizedResolver.resolve(Navigator.self, name: Navigators.rootNavigator.rawValue)!
        self.cartRepository = cartRepository ?? DIContainer.shared.synchronizedResolver.resolve(ICartRepository.self)!
    }
    
    private let orderRepository: IOrderRepository
    private let cartRepository: ICartRepository
    
    var selectedAddress: AddressResponseModel?
    
    private let rootNavigator: Navigator
    
    func getAddressList() async {
        let response = await withLoader {
            await self.orderRepository.getAddressList()
        }
        
        if let data = response.data {
            addresses = data
            if !data.isEmpty {
                selectedAddress = data.first
            }
        }
    }
    
    var addresses: [AddressResponseModel] = []
    var orderNote: String = ""
    var showAddAddressSheet: Bool = false
    
    var selectedPaymentMethod: String = .init(localized: "L.Credit Card")
    
    let paymentMethods: [String] = [
        String(localized: "L.Cash On Delivery"),
        String(localized: "L.Credit Card"),
        String(localized: "L.Bank Transfer"),
    ]
    
    func placeOrder() async {
        let requestModel = PlaceOrderRequestModel(
            orderNote: orderNote,
            paymentMethod: "CREDIT_CARD_ON_DELIVERY",
            addressId: selectedAddress!.id!
        )
        
        let response = await withLoader {
            await self.orderRepository.placeOrder(request: requestModel).showMessage()
        }
            
        if response.isSuccess {
            self.cartRepository.deleteAllCartItemsLocally()
            rootNavigator.popCartToRoot()
        }
    }
    
    func addNewAddress(address: AddAddressRequestModel) async {
        let response = await withLoader {
            await self.orderRepository.addAddress(request: address).showMessage()
        }
        
        if response.isSuccess {
            showAddAddressSheet = false
            await getAddressList()
        }
    }
}
