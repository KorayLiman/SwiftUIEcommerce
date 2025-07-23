//
//  EnvironmentValuesExtensions.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 22.07.2025.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var networkManager = NetworkManager(baseURL: "", loader: ECLoader(), authStore: AuthStore(), userDefaultsManager: UserDefaultsManager())

    @Entry var rootNavigator = Navigator()

    @Entry var userDefaultsManager = UserDefaultsManager()
}
