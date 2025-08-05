//
//  HomeScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel()
    @State private var rootNavigator: Navigator

    init() {
        self.rootNavigator = DIContainer.shared.synchronizedResolver.resolve(Navigator.self, name: Navigators.rootNavigator.rawValue)!
    }

    var body: some View {
        @Bindable var viewModelBindable = viewModel
        TabView(selection: $viewModelBindable.selectedTab) {
            NavigationStack {
                ProductListScreen()
                    .toolbarBackground(.ecBackgroundVariant, for: .tabBar)
                   
            }

            .tabItem {
                Label("L.Products", systemImage: "house.fill")
            }.tag(0)

            NavigationStack {
                ProfileMenuScreen()
                    .toolbarBackground(.ecBackgroundVariant, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
            }
            .tabItem {
                Label("L.Profile", systemImage: "person.fill")
            }.tag(1)

            NavigationStack(path: $rootNavigator.cartPath) {
                CartScreen()
                    .navigationDestination(for: CartRoute.self) { route in
                        switch route {
                        case .placeOrder:
                            PlaceOrderScreen()
                        }
                    }
                    .toolbarBackground(.ecBackgroundVariant, for: .tabBar)
                    .toolbarBackground(.visible, for: .tabBar)
            }

            .tabItem {
                Label("L.Cart", systemImage: "cart.fill")
            }.tag(2)
            .badge(viewModel.cartItemsCount)
        }

        .taskOnce {
            await viewModel.getCartItemsTotalCount()
        }
    }
}

#Preview {
    HomeScreen()
}
