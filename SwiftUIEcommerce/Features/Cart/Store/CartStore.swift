//
//  CartStore.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation

@Observable
final class CartStore {
    private let networkManager: NetworkManager
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager

        Task {
            let products = await getCartProducts()
            cartProducts = products
        }
    }

    private(set) var cartProducts: [CartResponseModel] = []

    private func getCartProducts() async -> [CartResponseModel] {
        let products = await networkManager.request([CartResponseModel].self, path: .cartItems, method: .get)
        if let products = products.data {
            return products
        } else {
            return []
        }
    }
}
