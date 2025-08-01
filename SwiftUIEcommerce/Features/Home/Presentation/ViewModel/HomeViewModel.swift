//
//  HomeViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation
import Foundation
import Combine


@MainActor
@Observable
final class HomeViewModel {
    var selectedTab: Int = 0
    var cartItemsCount: Int = 0
    
    init() {
        cartRepository.cartEventStream.receive(on: DispatchQueue.main).sink { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case .productAddedToCart(_):
                cartItemsCount += 1
                
            case .productRemovedFromCart(_):
                cartItemsCount -= 1
            }
        }
        .store(in: &cancellables)
    }

    private var cartRepository: ICartRepository {
        DIContainer.shared.synchronizedResolver.resolve(ICartRepository.self)!
    }
    
    private var cancellables = Set<AnyCancellable>()

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
