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
    private var cartItems: [CartItemResponseModel] = []

    private var productListRepository: IProductListRepository {
        DIContainer.shared.synchronizedResolver.resolve(IProductListRepository.self)!
    }

    private var cartRepository: ICartRepository {
        DIContainer.shared.synchronizedResolver.resolve(ICartRepository.self)!
    }

    func getCartItems() async {
        let data = await withLoader {
            await self.cartRepository.getCartItems().showMessage()
        }.data
        if let data = data {
            self.cartItems = data
        }
    }

    func getProductCategories() async {
        let categories = await productListRepository.getProductCategories().showMessage().data
        var categoryList = [CategoryResponseModel.all()]
        if let categories = categories, !categories.isEmpty {
            categoryList.append(contentsOf: categories)
        }

        self.categories = categoryList
    }

    func getAllProducts() async {
        let response = await productListRepository.getAllProducts().showMessage().data
        if let response = response {
            self.products = response
        }
    }

    func getProductsByCategory(category: CategoryResponseModel) async {
        if category == .all() {
            await self.getAllProducts()
        } else {
            if let id = category.id {
                let products = await productListRepository.getProductsByCategoryId(id).showMessage().data
                if let products = products {
                    self.products = products
                }
            }
        }
    }

    func addToCart(product: ProductResponseModel) async {
        guard product.id != nil else { return }
        let requestModel = AddToCartRequestModel(productId: product.id!)

        let response = await withLoader {
            await self.cartRepository.addToCart(requestModel).showMessage()
        }
    }

    func getCartItemCount(product: ProductResponseModel) -> Int {
        self.cartItems.filter { $0.product?.id == product.id }.count
    }
}
