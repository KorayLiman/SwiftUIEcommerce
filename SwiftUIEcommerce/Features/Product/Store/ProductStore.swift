//
//  ProductStore.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import Observation

@Observable
final class ProductStore {
    init(networkManager: NetworkManager, toastManager: ToastManager) {
        self.networkManager = networkManager
        self.toastManager = toastManager
    }

    private let networkManager: NetworkManager
    private let toastManager: ToastManager

    func getProductCategories() async -> [CategoryResponseModel] {
        let response = await networkManager.request([CategoryResponseModel].self, path: .category, method: .get).showMessage(toastManager)

        var categoryList = response.data ?? []
        if categoryList.isEmpty {
            categoryList.append(CategoryResponseModel.all())
        }
        else {
            categoryList.insert(CategoryResponseModel.all(), at: 0)
        }
        return categoryList
    }

    func getAllProducts() async -> [ProductResponseModel] {
        let response = await networkManager.request([ProductResponseModel].self, path: .product, method: .get).showMessage(toastManager)
        return response.data ?? []
    }

    func getProductsByCategoryId(_ categoryId: Int) async -> [ProductResponseModel] {
        let response = await networkManager.request([ProductResponseModel].self, path: .productByCategoryId(id: "\(categoryId)"), method: .get).showMessage(toastManager)
        return response.data ?? []
    }
}
