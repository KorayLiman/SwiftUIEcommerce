//
//  SplashView.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 10.07.2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var viewModel = SplashViewModel()
    var body: some View {
        Text("Splash Screen")
            .onAppear {
                viewModel.checkAuthenticationStatus()
            }
    }
}

#Preview {
    SplashScreen()
}
