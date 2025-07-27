//
//  LoginViewModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Observation

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

    private var rootNavigator: Navigator {
        DIContainer.shared.container.resolve(Navigator.self, name: Navigators.rootNavigator.rawValue)!
    }

    private var toastManager: ToastManager {
        DIContainer.shared.container.resolve(ToastManager.self)!
    }

    private var loginRepository: ILoginRepository {
        DIContainer.shared.container.resolve(ILoginRepository.self)!
    }

    private var authRepository: IAuthRepository {
        DIContainer.shared.container.resolve(IAuthRepository.self)!
    }

    func goToForgotPassword() {
         rootNavigator.push(.forgotPassword)
    }

    func login() {
        Task {
            let loginRequestModel = LoginRequestModel(username: usernameLogin, password: passwordLogin)
            let response = await loginRepository.login(request: loginRequestModel)
            if let data = response {
                authRepository.authStateStream.send(.authenticated(data))
            }
        }
    }

    func register() {
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

        Task {
            let registerRequestModel = RegisterRequestModel(
                name: nameRegister,
                surname: surnameRegister,
                email: emailRegister,
                phoneCode: phoneCodeRegister,
                phoneNumber: phoneNumberRegister,
                username: usernameRegister,
                password: passwordRegister
            )

            let result = await loginRepository.register(request: registerRequestModel)

            if result {
                let loginRequestModel = LoginRequestModel(username: usernameRegister, password: passwordRegister)
                let loginResponseModel = await loginRepository.login(request: loginRequestModel)

                if let response = loginResponseModel {
                    authRepository.authStateStream.send(.authenticated(response))
                }
            }
        }
    }
}
