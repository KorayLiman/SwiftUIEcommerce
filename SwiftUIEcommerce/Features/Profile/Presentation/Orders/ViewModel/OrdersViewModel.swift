//
//  OrdersViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 7.08.2025.
//

import Observation

@MainActor
@Observable
final class OrdersViewModel {
    init(orderRepository: IOrderRepository? = nil) {
        self.orderRepository = orderRepository ?? DIContainer.shared.synchronizedResolver.resolve(IOrderRepository.self)!
    }
    
    let orderRepository: IOrderRepository
    
    var orders: [OrderResponseModel] = []
    
    func getOrders() async {
        let response = await withLoader {
            await self.orderRepository.getOrders().showMessage()
        }
        if let response = response.data {
            orders = response
        }
    }
    
    func cancelOrder(orderId: Int) async {
        let response = await withLoader {
            await self.orderRepository.cancelOrder(request: CancelOrderRequestModel(id: orderId, orderStatus: "CANCELLED")).showMessage()
        }
        if response.isSuccess {
            await getOrders()
        }
    }
}
