//
//  HomeViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Combine
import Foundation
import Observation

@MainActor
@Observable
final class HomeViewModel {
    var selectedTab: Int = 0
    var cartItemsCount: Int = 0

    init(cartRepository: ICartRepository? = nil) {
        self.cartRepository = cartRepository ?? DIContainer.shared.synchronizedResolver.resolve(ICartRepository.self)!

        self.cartRepository.cartEventStream.receive(on: DispatchQueue.main).sink { [weak self] event in
            guard let self = self else { return }

            switch event {
            case .productAddedToCart:
                Task {
                    await self.getCartItemsTotalCount()
                }

            case .productRemovedFromCart:
                Task {
                    await self.getCartItemsTotalCount()
                }

            case .allCartItemsDeleted:
                break
            }
        }
        .store(in: &cancellables)
    }

    private let cartRepository: ICartRepository

    private var cancellables = Set<AnyCancellable>()

    func getCartItemsTotalCount() async {
        let response = await cartRepository.getCartItems().showMessage()
        if let data = response.data {
            let uniqueProducts = Set(data.compactMap { $0.product?.id })
            cartItemsCount = uniqueProducts.count
        }
    }

    func deleteAllCartItems() async {
        _ = await withLoader {
            await self.cartRepository.deleteAllCartItems().showMessage()
        }
    }

    func getNavigationTitle() -> String {
        switch selectedTab {
        case 0:
            String(localized: "L.Products")
        case 1:
            String(localized: "L.Profile")
        case 2:
            String(localized: "L.Cart")
        default:
            ""
        }
    }
}
