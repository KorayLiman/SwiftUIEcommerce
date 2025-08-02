//
//  ProductStore.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import Combine
import Observation
import Foundation

@Observable
final class ProductListViewModel {
    init(productListRepository: IProductListRepository? = nil, cartRepository: ICartRepository? = nil) {
        self.productListRepository = productListRepository ?? DIContainer.shared.synchronizedResolver.resolve(IProductListRepository.self)!
        self.cartRepository = cartRepository ?? DIContainer.shared.synchronizedResolver.resolve(ICartRepository.self)!

        self.cartRepository.cartEventStream.receive(on: DispatchQueue.main).sink { [weak self] event in

            guard let self = self else { return }

            switch event {
            case .productAddedToCart(_):
                Task {
                    await self.getCartItems()
                }

            case .productRemovedFromCart(_):
                Task {
                    await self.getCartItems()
                }
            case .allCartItemsDeleted:
                 removeAllCartItems()
            }
        }
        .store(in: &self.cancellables)
    }

    private var cancellables = Set<AnyCancellable>()
    var selectedCategory: CategoryResponseModel = .all()
    var categories: [CategoryResponseModel] = []
    var products: [ProductResponseModel] = []
    private var cartItems: [CartItemResponseModel] = []

    private let productListRepository: IProductListRepository

    private let cartRepository: ICartRepository

    func getCartItems() async {
        let data = await withLoader {
            await self.cartRepository.getCartItems()
        }.data
        if let data = data {
            await MainActor.run {
                self.cartItems = data
            }
        }
    }
    
    private func removeAllCartItems()  {
         cartItems.removeAll()
    }

    func getProductCategories() async {
        let categories = await productListRepository.getProductCategories().data

        await MainActor.run {
            var categoryList = [CategoryResponseModel.all()]
            if let categories = categories, !categories.isEmpty {
                categoryList.append(contentsOf: categories)
            }
            self.categories = categoryList
        }
    }

    func getAllProducts() async {
        let response = await productListRepository.getAllProducts().data
        if let response = response {
            await MainActor.run {
                self.products = response
            }
        }
    }

    func getProductsByCategory(category: CategoryResponseModel) async {
        if category == .all() {
            await self.getAllProducts()
        } else {
            if let id = category.id {
                let products = await productListRepository.getProductsByCategoryId(id).data
                if let products = products {
                    await MainActor.run {
                        self.products = products
                    }
                }
            }
        }
    }

    func addToCart(product: ProductResponseModel) async {
        guard product.id != nil else { return }
        let requestModel = AddToCartRequestModel(productId: product.id!)

        _ = await withLoader {
            await self.cartRepository.addToCart(requestModel)
        }
       
    }

    func removeFromCart(product: ProductResponseModel) async {
        guard let productId = product.id else { return }
        guard let lastIndex = self.cartItems.lastIndex(where: { $0.product?.id == productId }) else { return }

        let requestModel = RemoveFromCartRequestModel(cartItemId: self.cartItems[lastIndex].id!)

        _ = await withLoader {
            await self.cartRepository.removeFromCart(requestModel)
        }

       
    }

    func getCartItemCount(product: ProductResponseModel) -> Int {
        self.cartItems.filter { $0.product?.id == product.id }.count
    }
}
