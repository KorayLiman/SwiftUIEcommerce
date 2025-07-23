//
//  SplashView.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 10.07.2025.
//

import SwiftUI

struct SplashScreen: View {
    @Environment(AuthStore.self) private var authStore
    @Environment(\.userDefaultsManager) private var userDefaultsManager
    var body: some View {
        Text("Splash Screen")
            .onAppear {
                if let loginResponseModel = try? userDefaultsManager.getObject(LoginResponseModel.self, forKey: .loginResponseModel) {
                    authStore.authState = .authenticated(loginResponseModel)
                }
                else {
                    authStore.authState = .unAuthenticated
                }
            }
    }
}

#Preview {
    SplashScreen()
        .environment(AuthStore())
        .environment(\.userDefaultsManager, UserDefaultsManager())
}
