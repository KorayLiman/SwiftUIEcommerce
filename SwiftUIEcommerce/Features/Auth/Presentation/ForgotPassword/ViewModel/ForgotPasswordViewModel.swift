//
//  ForgotPasswordViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation

@MainActor
@Observable
final class ForgotPasswordViewModel {
    var phoneCode: String = "+90"
    var phoneNumber: String = ""

    init(forgotPasswordRepository: IForgotPasswordRepository? = nil, rootNavigator: Navigator? = nil) {
        self.forgotPasswordRepository = forgotPasswordRepository ?? DIContainer.shared.synchronizedResolver.resolve(IForgotPasswordRepository.self)!
        self.rootNavigator = rootNavigator ?? DIContainer.shared.synchronizedResolver.resolve(Navigator.self, name: Navigators.rootNavigator.rawValue)!
    }

    private let forgotPasswordRepository: IForgotPasswordRepository

    private let rootNavigator: Navigator

    func sendOtp() async {
        let sendOtpCodeRequestModel = SendOtpCodeRequestModel(phoneCode: phoneCode, phoneNumber: phoneNumber)
        let res = await withLoader {
            await self.forgotPasswordRepository.sendOtp(requestModel: sendOtpCodeRequestModel).showMessage()
        }

        if res.isSuccess {
            rootNavigator.replaceCurrent(.resetPassword(phoneCode: phoneCode, phoneNumber: phoneNumber))
        }
    }
}
