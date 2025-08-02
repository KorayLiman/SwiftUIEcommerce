//
//  AuthStore.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 13.07.2025.
//

import Combine
import Observation
import Foundation

@MainActor
@Observable
final class AuthViewModel {
    init(authRepository: IAuthRepository? = nil, userDefaultsManager: IUserDefaultsManager? = nil) {
        
        self.authRepository = authRepository ?? DIContainer.shared.synchronizedResolver.resolve(IAuthRepository.self)!
        self.userDefaultsManager = userDefaultsManager ?? DIContainer.shared.synchronizedResolver.resolve(IUserDefaultsManager.self)!
        
        self.authRepository.authStateStream.receive(on: DispatchQueue.main).sink { [weak self] state in
            guard let self = self else { return }

            switch state {
            case .unknown:
                self.authState = .unknown

            case .authenticated(let loginResponse):
                self.onLogin(loginResponse)

            case .unAuthenticated:
                self.onLogout()
            }
        }
        .store(in: &cancellables)
    }

    private var cancellables = Set<AnyCancellable>()
    private(set) var authState: AuthState = .unknown
    
    private let userDefaultsManager: IUserDefaultsManager

    private let authRepository: IAuthRepository


    func onLogin(_ loginResponse: LoginResponseModel) {
        let result = userDefaultsManager.setObject(loginResponse, forKey: .loginResponseModel)
        if result == true {
            authState = .authenticated(loginResponse)
        }
    }

    func onLogout() {
        userDefaultsManager.removeObject(forKey: .loginResponseModel)
        authState = .unAuthenticated
    }
}
