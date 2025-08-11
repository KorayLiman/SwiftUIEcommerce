//
//  AddressesViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 9.08.2025.
//

import Observation

@MainActor
@Observable
final class AddressesViewModel {
    init(orderRepository: IOrderRepository? = nil) {
        self.orderRepository = orderRepository ?? DIContainer.shared.synchronizedResolver.resolve(IOrderRepository.self)!
    }
    
    private let orderRepository: IOrderRepository
    
    var addresses: [AddressResponseModel] = []
    var showAddAddressSheet: Bool = false
    
    func getAddressList() async {
        let response = await withLoader {
            await self.orderRepository.getAddressList()
        }
        if let data = response.data {
            addresses = data
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
    
    func deleteAddress(id: Int) async {
        let response = await withLoader {
            await self.orderRepository.deleteAddress(id: id).showMessage()
        }
     
        if response.isSuccess {
            await getAddressList()
        }
    }
}
