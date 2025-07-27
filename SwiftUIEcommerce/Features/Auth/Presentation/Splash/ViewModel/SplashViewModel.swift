//
//  SplashViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation

@Observable
final class SplashViewModel {
    private var userDefaultsManager: IUserDefaultsManager {
        DIContainer.shared.container.resolve(IUserDefaultsManager.self)!
    }

    private var authRepository: IAuthRepository {
        DIContainer.shared.container.resolve(IAuthRepository.self)!
    }

    func checkAuthenticationStatus() {
        if let loginResponseModel = userDefaultsManager.getObject(LoginResponseModel.self, forKey: .loginResponseModel) {
            authRepository.authStateStream.send(.authenticated(loginResponseModel))
        }
        else {
            authRepository.authStateStream.send(.unAuthenticated)
        }
    }
}
