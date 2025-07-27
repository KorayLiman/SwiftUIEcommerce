//
//  RootScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 13.07.2025.
//

import SwiftUI
import UIKit

struct RootScreen: View {
    @State private var loader: ECLoader
    @State private var toastManager: ToastManager
    @State private var authViewModel: AuthViewModel
    @State private var rootNavigator: Navigator

    private var userDefaultsManager: IUserDefaultsManager
    private var networkManager: NetworkManager

    init() {
        self.loader = DIContainer.shared.container.resolve(ECLoader.self) ?? ECLoader()
        self.toastManager = DIContainer.shared.container.resolve(ToastManager.self) ?? ToastManager()
        self.authViewModel = AuthViewModel()
        self.rootNavigator = DIContainer.shared.container.resolve(Navigator.self, name: Navigators.rootNavigator.rawValue) ?? Navigator()
        self.userDefaultsManager = DIContainer.shared.container.resolve(IUserDefaultsManager.self) ?? UserDefaultsManager()
        self.networkManager = DIContainer.shared.container.resolve(NetworkManager.self)!
    }

    var body: some View {
        NavigationStack(path: $rootNavigator.path) {
         
            
            ZStack {
               
                switch authViewModel.authState {
                case .unknown:
                    SplashScreen().background(.ecBackgroundVariant)
                case .authenticated:
                    HomeScreen().background(.ecBackgroundVariant)
                case .unAuthenticated:
                    LoginScreen().background(.ecBackgroundVariant)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .productList:
                    Text("productList")
                case .productDetail:
                    Text("productDetail")
                case .forgotPassword:
                    ForgotPasswordScreen().background(.ecBackgroundVariant)
                case .resetPassword(let phoneCode, let phoneNumber):
                    ResetPasswordScreen(phoneCode: phoneCode, phoneNumber: phoneNumber).background(.ecBackgroundVariant)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
         
        }

        .overlay {
            if let toast = toastManager.getActiveToast {
                VStack {
                    Spacer()
                    ECToastView(toast: toast)
                        .padding(.bottom, 16)
                }
            }
        }

        .overlay {
            if loader.isActive {
                ZStack {
                    Color.black.opacity(0.5)
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    RootScreen()
}
