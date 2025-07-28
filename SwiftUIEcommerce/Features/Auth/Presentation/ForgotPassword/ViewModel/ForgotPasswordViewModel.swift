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
        DIContainer.shared.synchronizedResolver.resolve(IForgotPasswordRepository.self)!
    }

    private var rootNavigator: Navigator {
        DIContainer.shared.synchronizedResolver.resolve(Navigator.self, name: Navigators.rootNavigator.rawValue)!
    }

    func sendOtp() async{
       
            let sendOtpCodeRequestModel = SendOtpCodeRequestModel(phoneCode: phoneCode, phoneNumber: phoneNumber)
            let res = await withLoader {
                await self.forgotPasswordRepository.sendOtp(requestModel: sendOtpCodeRequestModel).showMessage()
            }

            if res.isSuccess {
                rootNavigator.replaceCurrent(.resetPassword(phoneCode: phoneCode, phoneNumber: phoneNumber))
            }
        
    }
}
