//
//  AuthStore.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 13.07.2025.
//

import Combine
import Observation

@MainActor
@Observable
final class AuthViewModel {
    init() {
        
        authRepository.authStateStream.sink { [weak self] state in
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

    private var userDefaultsManager: IUserDefaultsManager {
        DIContainer.shared.synchronizedResolver.resolve(IUserDefaultsManager.self)!
    }

    private var authRepository: IAuthRepository {
        DIContainer.shared.synchronizedResolver.resolve(IAuthRepository.self)!
    }

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
