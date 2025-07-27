//
//  ResetPasswordViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation

@Observable
final class ResetPasswordViewModel {
    var otpCode: String = ""
    var password: String = ""
    var confirmPassword: String = ""

    private var resetPasswordRepository: IResetPasswordRepository {
        DIContainer.shared.container.resolve(IResetPasswordRepository.self)!
    }

    private var rootNavigator: Navigator {
        DIContainer.shared.container.resolve(Navigator.self, name: Navigators.rootNavigator.rawValue)!
    }

    func resetPassword(phoneCode: String, phoneNumber: String) {
        let resetPasswordRequestModel = ResetPasswordRequestModel(phoneCode: phoneCode, phoneNumber: phoneNumber, code: otpCode, newPassword: password)

        Task {
            let isSuccess = await resetPasswordRepository.resetPassword(request: resetPasswordRequestModel)

            if isSuccess {
                rootNavigator.popToRoot()
            }
        }
    }
}
