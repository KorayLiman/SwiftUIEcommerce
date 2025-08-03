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
    init(placeOrderRepository: IPlaceOrderRepository? = nil, rootNavigator: Navigator? = nil, cartRepository: ICartRepository? = nil) {
        self.placeOrderRepository = placeOrderRepository ?? DIContainer.shared.synchronizedResolver.resolve(IPlaceOrderRepository.self)!
        
        self.rootNavigator = rootNavigator ?? DIContainer.shared.synchronizedResolver.resolve(Navigator.self, name: Navigators.rootNavigator.rawValue)!
        self.cartRepository = cartRepository ?? DIContainer.shared.synchronizedResolver.resolve(ICartRepository.self)!
    }
    
    private let placeOrderRepository: IPlaceOrderRepository
    private let cartRepository: ICartRepository
    
    var selectedAddress: AddressResponseModel?
    
    private let rootNavigator: Navigator
    
    func getAddressList() async {
        let response = await withLoader {
            await self.placeOrderRepository.getAddressList()
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
            await self.placeOrderRepository.placeOrder(request: requestModel).showMessage()
        }
            
        if response.isSuccess {
            _ = await withLoader {
                await self.cartRepository.deleteAllCartItems()
            }
            
            rootNavigator.popCartToRoot()
        }
    }
}
