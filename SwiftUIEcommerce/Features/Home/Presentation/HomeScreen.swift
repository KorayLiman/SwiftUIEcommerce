//
//  HomeScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI

struct HomeScreen: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ProductListScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                }.tag(0)
            Text("Home2")
                .tabItem {
                    Image(systemName: "person.fill")
                }.tag(1)
            Text("Home3")
                .tabItem {
                    Image(systemName: "basket.fill")
                }.tag(2)
        }
    }
}

#Preview {
    HomeScreen()
}
