//
//  LoginViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation

@MainActor
@Observable
final class LoginViewModel {
    var selectedTab: Int = 0
    let tabs = [String(localized: "L.Login"), String(localized: "L.Register")]

    var usernameLogin: String = ""
    var passwordLogin: String = ""

    var phoneCodeRegister: String = "+90"
    var phoneNumberRegister: String = ""
    var usernameRegister: String = ""
    var passwordRegister: String = ""
    var confirmPasswordRegister: String = ""
    var nameRegister: String = ""
    var surnameRegister: String = ""
    var emailRegister: String = ""
    var isUserAgreementAcceptedRegister: Bool = false
    var isPrivacyPolicyAcceptedRegister: Bool = false

    init(rootNavigator: Navigator? = nil,
         toastManager: ToastManager? = nil,
         loginRepository: ILoginRepository? = nil,
         authRepository: IAuthRepository? = nil)
    {
        self.rootNavigator = rootNavigator ?? DIContainer.shared.synchronizedResolver.resolve(Navigator.self,
                                                                                              name: Navigators.rootNavigator.rawValue)!
        self.toastManager = toastManager ?? DIContainer.shared.synchronizedResolver.resolve(ToastManager.self)!
        self.loginRepository = loginRepository ?? DIContainer.shared.synchronizedResolver.resolve(ILoginRepository
            .self)!
        self.authRepository = authRepository ?? DIContainer.shared.synchronizedResolver.resolve(IAuthRepository.self)!
    }

    private let rootNavigator: Navigator

    private let toastManager: ToastManager

    private let loginRepository: ILoginRepository

    private let authRepository: IAuthRepository

    func goToForgotPassword() {
        rootNavigator.push(.forgotPassword)
    }

    func login() async {
        let loginRequestModel = LoginRequestModel(username: usernameLogin, password: passwordLogin)
        let response = await withLoader {
            await self.loginRepository.login(request: loginRequestModel).showMessage()
        }
        if let data = response.data {
            authRepository.authStateStream.send(.authenticated(data))
        }
    }

    func register() async {
        var errorMessages: [String] = []

        if passwordRegister != confirmPasswordRegister {
            errorMessages.append("L.PasswordsDoNotMatch")
        }

        if !emailRegister.isValidEmail {
            errorMessages.append("L.InvalidEmail")
        }

        if errorMessages.count > 0 {
            toastManager.showToast(ECToast(style: .error, message: errorMessages.joined(separator: "\n")))
            return
        }

        let registerRequestModel = RegisterRequestModel(
            name: nameRegister,
            surname: surnameRegister,
            email: emailRegister,
            phoneCode: phoneCodeRegister,
            phoneNumber: phoneNumberRegister,
            username: usernameRegister,
            password: passwordRegister
        )

        let result = await withLoader {
            await self.loginRepository.register(request: registerRequestModel).showMessage()
        }

        if result.isSuccess {
            let loginRequestModel = LoginRequestModel(username: usernameRegister, password: passwordRegister)
            let loginResponseModel = await withLoader {
                await self.loginRepository.login(request: loginRequestModel).showMessage()
            }

            if let response = loginResponseModel.data {
                authRepository.authStateStream.send(.authenticated(response))
            }
        }
    }
}
