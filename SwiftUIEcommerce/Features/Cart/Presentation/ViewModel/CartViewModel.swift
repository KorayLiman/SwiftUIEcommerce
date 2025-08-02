//
//  CartViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 2.08.2025.
//

import Combine
import Foundation
import Observation
import OrderedCollections

@MainActor
@Observable
final class CartViewModel {
    init(cartRepository: ICartRepository? = nil, rootNavigator: Navigator? = nil) {
        self.cartRepository = cartRepository ?? DIContainer.shared.synchronizedResolver.resolve(ICartRepository.self)!
        self.rootNavigator = rootNavigator ?? DIContainer.shared.synchronizedResolver.resolve(Navigator.self, name: Navigators.rootNavigator.rawValue)!

        self.cartRepository.cartEventStream.receive(on: DispatchQueue.main).sink { [weak self] event in

            guard let self = self else { return }

            switch event {
            case .productAddedToCart:
                Task {
                    await self.getCartItems()
                }

            case .productRemovedFromCart:
                Task {
                    await self.getCartItems()
                }
            case .allCartItemsDeleted:
                 removeAllCartItems()
            
            }
        }
        .store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()
    private var rootNavigator: Navigator
        
    private let cartRepository: ICartRepository
    var cartItems: [CartItemResponseModel] = []

    var mergedCartItems: [MergedCartItemModel] {
        let grouped = OrderedDictionary(grouping: cartItems, by: { $0.product?.id ?? -1 })

        return grouped.compactMap { key, items in
            guard let product = items.first?.product, key != -1 else { return nil }

            return MergedCartItemModel(
                id: key,
                product: product,
                quantity: items.count
            )
        }
    }
    
    func removeAllCartItems() {
        cartItems.removeAll()
    }

    func getCartItems() async {
        let response = await withLoader {
            await self.cartRepository.getCartItems()
        }

        if let data = response.data {
            cartItems = data
        }
    }
    
    func goToPlaceOrderPage (){
        rootNavigator.push(.placeOrder)
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
        guard let lastIndex = cartItems.lastIndex(where: { $0.product?.id == productId }) else { return }

        let requestModel = RemoveFromCartRequestModel(cartItemId: cartItems[lastIndex].id!)

        _ = await withLoader {
            await self.cartRepository.removeFromCart(requestModel)
        }

     
    }

    func getCartItemCount(product: ProductResponseModel) -> Int {
        cartItems.filter { $0.product?.id == product.id }.count
    }
}
