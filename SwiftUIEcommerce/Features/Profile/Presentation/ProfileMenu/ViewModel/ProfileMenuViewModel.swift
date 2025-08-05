//
//  ProfileMenuViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 6.08.2025.
//

import Observation

@MainActor
@Observable
final class ProfileMenuViewModel {
    init(userDefaultsManager: UserDefaultsManager? = nil, authRepository: IAuthRepository? = nil) {
        self.userDefaultsManager = userDefaultsManager ?? DIContainer.shared.synchronizedResolver.resolve(IUserDefaultsManager.self)!
        self.authRepository = authRepository ?? DIContainer.shared.synchronizedResolver.resolve(IAuthRepository.self)!
    }

    let userDefaultsManager: IUserDefaultsManager
    let authRepository: IAuthRepository
    var user: LoginResponseModel?

    func getCurrentUserInfo() {
        if let userInfo = userDefaultsManager.getObject(LoginResponseModel.self, forKey: .loginResponseModel) {
            user = userInfo
        }
    }
    
    func logout() {
        authRepository.authStateStream.send(.unAuthenticated)
    }
}
