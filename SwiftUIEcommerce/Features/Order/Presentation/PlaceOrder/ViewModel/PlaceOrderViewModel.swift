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
    init(placeOrderRepository: IPlaceOrderRepository? = nil) {
        self.placeOrderRepository = placeOrderRepository ?? DIContainer.shared.synchronizedResolver.resolve(IPlaceOrderRepository.self)!
    }
    
    private let placeOrderRepository: IPlaceOrderRepository
    
    var selectedAddress: AddressResponseModel?
    
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
}
