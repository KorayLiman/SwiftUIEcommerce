//
//  ChangePasswordViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 10.08.2025.
//

import Observation

@MainActor
@Observable
final class ChangePasswordViewModel {
    init(changePasswordRepository: IChangePasswordRepository? = nil, authRepository: IAuthRepository? = nil) {
        self.changePasswordRepository = changePasswordRepository ?? DIContainer.shared.synchronizedResolver.resolve(IChangePasswordRepository.self)!
        self.authRepository = authRepository ?? DIContainer.shared.synchronizedResolver.resolve(IAuthRepository.self)!
    }
    
    var currentPassword: String = ""
    var newPassword: String = ""
    var confirmPassword: String = ""
    
    private let changePasswordRepository: IChangePasswordRepository
    private let authRepository: IAuthRepository
    
    
    func changePassword() async {
        
        guard newPassword == confirmPassword else { return }
        let changePasswordRequestModel = ChangePasswordRequestModel(oldPassword: currentPassword, newPassword: newPassword)
        
        let res = await withLoader {
            await self.changePasswordRepository.changePassword(request: changePasswordRequestModel).showMessage()
        }
        
        if res.isSuccess {
            authRepository.authStateStream.send(.unAuthenticated)
        }
        
    }
}
