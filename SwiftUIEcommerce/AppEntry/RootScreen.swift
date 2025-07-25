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
    @State private var authStore: AuthStore
    @State private var rootNavigator: Navigator

    private var userDefaultsManager: UserDefaultsManager
    private var networkManager: NetworkManager

    init() {
        let loader = ECLoader()
        let authStore = AuthStore()
        let toastManager = ToastManager()
        let userDefaultsManager = UserDefaultsManager()
        let rootNavigator = Navigator()
        self.loader = loader
        self.toastManager = toastManager
        self.authStore = authStore
        self.rootNavigator = rootNavigator
        self.userDefaultsManager = userDefaultsManager
        self.networkManager = NetworkManager(baseURL: AppConstants.baseUrl, loader: loader, authStore: authStore, userDefaultsManager: userDefaultsManager)
    }

    var body: some View {
        NavigationStack(path: $rootNavigator.path) {
            ZStack {
                switch authStore.authState {
                case .unknown:
                    SplashScreen()
                case .authenticated:
                    HomeScreen()
                case .unAuthenticated:
                    LoginScreen()
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .productList:
                    Text("productList")
                case .productDetail:
                    Text("productDetail")
                case .forgotPassword:
                    ForgotPasswordScreen()
                case .resetPassword(let phoneCode, let phoneNumber):
                    ResetPasswordScreen(phoneCode: phoneCode, phoneNumber: phoneNumber)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(.ecBackground)
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

        .environment(\.rootNavigator, rootNavigator)
        .environment(authStore)
        .environment(\.networkManager, networkManager)
        .environment(loader)
        .environment(toastManager)
        .environment(\.userDefaultsManager, userDefaultsManager)
        .onChange(of: authStore.authState) { oldValue, newValue in
            if oldValue == newValue { return }
            switch newValue {
            case .authenticated(let loginResponseModel):
                try? userDefaultsManager.setObject(loginResponseModel, forKey: .loginResponseModel)

            case .unAuthenticated:
                userDefaultsManager.removeObject(forKey: .loginResponseModel)

            case .unknown:
                break
            }
        }
    }
}

#Preview {
    RootScreen()
        .environment(\.rootNavigator, Navigator())
        .environment(AuthStore())
        .environment(\.networkManager, NetworkManager(baseURL: "", loader: ECLoader(), authStore: AuthStore(), userDefaultsManager: UserDefaultsManager()))
        .environment(ECLoader())
        .environment(ToastManager())
        .environment(\.userDefaultsManager, UserDefaultsManager())
}
