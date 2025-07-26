//
//  HomeScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedTab: Int = 0
    @Environment(ToastManager.self) private var toastManager
    @Environment(\.networkManager) private var networkManager
    @State private var cartStore: CartStore
    
    init() {
     
        
        _cartStore = State(initialValue: CartStore(networkManager: networkManager))
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
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
                  
                }.tag(2).toolbarBackground(.ecBackgroundVariant, for: .tabBar)
        }
   
        .navigationTitle(getNavigationTitle())
        .environment(ProductStore(networkManager: networkManager, toastManager: toastManager))
        .environment(cartStore)
    }
}

private extension HomeScreen {
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

#Preview {
    HomeScreen()
}
