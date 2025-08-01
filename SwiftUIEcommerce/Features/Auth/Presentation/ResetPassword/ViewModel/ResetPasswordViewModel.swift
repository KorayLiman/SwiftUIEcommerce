//
//  ResetPasswordViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation

@MainActor
@Observable
final class ResetPasswordViewModel {
    var otpCode: String = ""
    var password: String = ""
    var confirmPassword: String = ""

    private var resetPasswordRepository: IResetPasswordRepository {
        DIContainer.shared.synchronizedResolver.resolve(IResetPasswordRepository.self)!
    }

    private var rootNavigator: Navigator {
        DIContainer.shared.synchronizedResolver.resolve(Navigator.self, name: Navigators.rootNavigator.rawValue)!
    }

    func resetPassword(phoneCode: String, phoneNumber: String) async {
        let resetPasswordRequestModel = ResetPasswordRequestModel(phoneCode: phoneCode, phoneNumber: phoneNumber, code: otpCode, newPassword: password)

       
            let response = await withLoader {
                await self.resetPasswordRepository.resetPassword(request: resetPasswordRequestModel).showMessage()
            }

            if response.isSuccess {
                rootNavigator.popToRoot()
            }
        
    }
}
