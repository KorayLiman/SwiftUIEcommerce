//
//  HomeViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation

@MainActor
@Observable
final class HomeViewModel {
    var selectedTab: Int = 0
    var cartItemsCount: Int = 0

    private var cartRepository: ICartRepository {
        DIContainer.shared.synchronizedResolver.resolve(ICartRepository.self)!
    }

    func getCartItemsTotalCount() async {
        let response = await withLoader {
            await self.cartRepository.getCartItems().showMessage()
        }
        if let data = response.data {
            cartItemsCount = data.count
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
