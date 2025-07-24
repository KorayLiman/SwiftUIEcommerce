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

    var body: some View {
        TabView(selection: $selectedTab) {
            ProductListScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                }.tag(0)
            ECText(label: "Home2")
                .tabItem {
                    Image(systemName: "person.fill")
                }.tag(1)
            ECText(label: "Home3")
                .tabItem {
                    Image(systemName: "basket.fill")
                }.tag(2)
        }
        .navigationTitle(getNavigationTitle())
        .environment(ProductStore(networkManager: networkManager, toastManager: toastManager))
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
