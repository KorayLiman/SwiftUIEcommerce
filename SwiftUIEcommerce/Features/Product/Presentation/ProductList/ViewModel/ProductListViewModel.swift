//
//  ProductStore.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import Observation

@Observable
final class ProductListViewModel {
    var selectedCategory: CategoryResponseModel = .all()
    var categories: [CategoryResponseModel] = []
    var products: [ProductResponseModel] = []

    private var productListRepository: IProductListRepository {
        DIContainer.shared.container.resolve(IProductListRepository.self)!
    }

    func getProductCategories() async {
        let categories = await productListRepository.getProductCategories()
        var categoryList = [CategoryResponseModel.all()]
        if let categories = categories, !categories.isEmpty {
            categoryList.append(contentsOf: categories)
        }

        self.categories = categoryList
    }

    func getAllProducts() async {
        let response = await productListRepository.getAllProducts()
        if let response = response {
            self.products = response
        }
    }

    func getProductsByCategory(category: CategoryResponseModel) async {
        if category == .all() {
            await self.getAllProducts()
        } else {
            if let id = category.id {
                let products = await productListRepository.getProductsByCategoryId(id)
                if let products = products {
                    self.products = products
                }
            }
        }
    }
}
