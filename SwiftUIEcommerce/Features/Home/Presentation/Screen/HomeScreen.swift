//
//  HomeScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI

struct HomeScreen: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        @Bindable var viewModelBindable = viewModel
        TabView(selection: $viewModelBindable.selectedTab) {
            ProductListScreen()
                .tabItem {
                    Label("L.Products", systemImage: "house.fill")
                }.tag(0)
            ECText(label: "Home2")
                .tabItem {
                    Label("L.Profile", systemImage: "person.fill")
                }.tag(1)
            ECText(label: "Home3")
                .tabItem {
                    Label("L.Cart", systemImage: "cart.fill")
                }.tag(2)
                .badge(viewModel.cartItemsCount)
                .toolbarBackground(.ecBackgroundVariant, for: .tabBar)
        }
        
        .navigationTitle(viewModel.getNavigationTitle())
        .taskOnce {
          await  viewModel.getCartItemsTotalCount()
        }
    }
}

#Preview {
    HomeScreen()
}
