//
//  HomeViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation

@Observable

final class HomeViewModel {
    var selectedTab: Int = 0

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
