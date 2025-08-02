//
//  SplashViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation

@MainActor
@Observable
final class SplashViewModel {
    init(userDefaultsManager: IUserDefaultsManager? = nil,
         authRepository: IAuthRepository? = nil)
    {
        self.userDefaultsManager = userDefaultsManager ?? DIContainer.shared.synchronizedResolver.resolve(IUserDefaultsManager.self)!
        self.authRepository = authRepository ?? DIContainer.shared.synchronizedResolver.resolve(IAuthRepository.self)!
    }
    
    private let userDefaultsManager: IUserDefaultsManager

    private let authRepository: IAuthRepository
    
    func checkAuthenticationStatus() {
        if let loginResponseModel = userDefaultsManager.getObject(LoginResponseModel.self, forKey: .loginResponseModel) {
            authRepository.authStateStream.send(.authenticated(loginResponseModel))
        }
        else {
            authRepository.authStateStream.send(.unAuthenticated)
        }
    }
}
