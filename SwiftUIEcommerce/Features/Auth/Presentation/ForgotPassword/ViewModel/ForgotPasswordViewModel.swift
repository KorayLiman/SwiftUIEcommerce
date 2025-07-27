//
//  ForgotPasswordViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation

@Observable

final class ForgotPasswordViewModel {
    var phoneCode: String = "+90"
    var phoneNumber: String = ""

    private var forgotPasswordRepository: IForgotPasswordRepository {
        DIContainer.shared.container.resolve(IForgotPasswordRepository.self)!
    }

    private var rootNavigator: Navigator {
        DIContainer.shared.container.resolve(Navigator.self, name: Navigators.rootNavigator.rawValue)!
    }

    func sendOtp() {
        Task {
            let sendOtpCodeRequestModel = SendOtpCodeRequestModel(phoneCode: phoneCode, phoneNumber: phoneNumber)
            let res = await forgotPasswordRepository.sendOtp(requestModel: sendOtpCodeRequestModel)

            if res == true {
                rootNavigator.replaceCurrent(.resetPassword(phoneCode: phoneCode, phoneNumber: phoneNumber))
            }
        }
    }
}
