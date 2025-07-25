//
//  LoginView.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 10.07.2025.
//

import Alamofire
import SwiftUI

struct LoginScreen: View {
    @State private var selectedTab: Int = 0
    @Namespace private var buttonId
    private let tabs = [String(localized: "L.Login"), String(localized: "L.Register")]

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(tabs.indices, id: \.self) { index in
                    VStack(spacing: 4) {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                selectedTab = index
                            }
                        }) {
                            ECText(localizedStringKey: LocalizedStringKey(tabs[index]), foregroundColor: selectedTab == index ? .ecAccent : .secondary, font: .headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .contentShape(Rectangle())

                        Group {
                            if selectedTab == index {
                                Capsule()
                                    .fill(.ecAccent)
                                    .matchedGeometryEffect(id: "ID", in: buttonId)
                            } else {
                                Color.clear
                            }
                        }
                        .frame(height: 4)
                        .padding(.horizontal, 4)
                    }
                }
            }

            TabView(selection: $selectedTab) {
                LoginTabView()
                    .tag(0)

                RegisterTabView()
                    .tag(1)
            }
            .padding()
            .animation(.default, value: selectedTab)
        }
        .navigationTitle(Text(verbatim: "SwiftUI Ecommerce"))
        .padding(.horizontal)
    }
}

private struct LoginTabView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @FocusState private var focusedField: Field?
    @Environment(ECLoader.self) private var loader
    @Environment(\.networkManager) private var networkManager
    @Environment(ToastManager.self) private var toastManager
    @Environment(\.userDefaultsManager) private var userDefaultsManager
    @Environment(AuthStore.self) private var authStore
    @Environment(\.rootNavigator) private var rootNavigator

    var body: some View {
        ECScrollView {
            VStack(spacing: 12) {
                ECTextField(icon: "person", placeholder: "L.Username", text: $username)
                    .focused($focusedField, equals: .username)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }
                    .textInputAutocapitalization(.never)
                    .textContentType(.username)

                ECTextField(icon: "lock", placeholder: "L.Password", text: $password, isSecure: true)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.done)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)

                HStack {
                    Spacer()
                    ECTextButton(localizedStringKey: "L.ForgotPassword") {
                        rootNavigator.push(.forgotPassword)
                    }
                }

                ECFilledButton(localizedStringKey: "L.Login", maxWidth: .infinity) {
                    login()
                }.disabled(username.isEmpty || password.isEmpty)
            }
        }
      
    }
}

private struct RegisterTabView: View {
    @State private var phoneCode: String = "+90"
    @State private var phoneNumber: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var name: String = ""
    @State private var surname: String = ""
    @State private var email: String = ""
    @State private var isUserAgreementAccepted: Bool = false
    @State private var isPrivacyPolicyAccepted: Bool = false
    @FocusState private var focusedField: Field?
    @Environment(ToastManager.self) private var toastManager
    @Environment(AuthStore.self) private var authStore
    @Environment(\.networkManager) private var networkManager
    @Environment(ECLoader.self) private var loader

    var body: some View {
        ECScrollView {
            VStack(spacing: 12) {
                HStack {
                    ECTextField(text: $phoneCode)
                        .keyboardType(.phonePad)
                        .submitLabel(.next)
                        .frame(minWidth: 80)
                        .onChange(of: phoneCode) { _, newValue in
                            let digits = newValue.filter { $0.isNumber }.prefix(2)
                            phoneCode = "+" + digits
                        }
                        .onAppear {
                            let digits = phoneCode.filter { $0.isNumber }.prefix(2)
                            phoneCode = "+" + digits
                        }
                        .focused($focusedField, equals: .phoneCode)

                    ECTextField(placeholder: "L.PhoneNumber", text: $phoneNumber)
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)
                        .submitLabel(.next)
                        .layoutPriority(1)
                        .focused($focusedField, equals: .phoneNumber)
                }
                ECTextField(icon: "person", placeholder: "L.Username", text: $username)
                    .keyboardType(.default)
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .username)
                    .onSubmit {
                        focusedField = .password
                    }
                ECTextField(icon: "lock", placeholder: "L.Password", text: $password, isSecure: true)
                    .submitLabel(.next)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .password)
                    .onSubmit {
                        focusedField = .confirmPassword
                    }

                ECTextField(icon: "lock", placeholder: "L.ConfirmPassword", text: $confirmPassword, isSecure: true)
                    .submitLabel(.next)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .confirmPassword)
                    .onSubmit {
                        focusedField = .name
                    }

                ECTextField(icon: "person", placeholder: "L.Name", text: $name)
                    .submitLabel(.next)
                    .keyboardType(.default)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                    .focused($focusedField, equals: .name)
                    .onSubmit {
                        focusedField = .surname
                    }

                ECTextField(icon: "person", placeholder: "L.Surname", text: $surname)
                    .submitLabel(.next)
                    .keyboardType(.default)
                    .textContentType(.familyName)
                    .textInputAutocapitalization(.words)
                    .focused($focusedField, equals: .surname)
                    .onSubmit {
                        focusedField = .email
                    }

                ECTextField(icon: "envelope", placeholder: "L.Email", text: $email)
                    .submitLabel(.done)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .email)

                Group {
                    ECSwitch(isOn: $isUserAgreementAccepted) {
                        ECText(localizedStringKey: "L.UserAgreement")
                    }

                    ECSwitch(isOn: $isPrivacyPolicyAccepted) {
                        ECText(localizedStringKey: "L.PrivacyPolicy")
                    }
                }.padding(.horizontal, 12)

                ECFilledButton(localizedStringKey: "L.Register", maxWidth: .infinity) {
                    register()

                }.disabled(phoneCode.isEmpty || phoneNumber.isEmpty || username.isEmpty || password.isEmpty || confirmPassword.isEmpty || name.isEmpty || surname.isEmpty || email.isEmpty || !isUserAgreementAccepted || !isPrivacyPolicyAccepted)
            }
        }
    }
}

private extension LoginTabView {
    func login() {
        focusedField = nil

        Task {
            let loginRequestModel = LoginRequestModel(username: username, password: password)

            let response = await withLoader(loader: loader) {
                await networkManager.request(LoginResponseModel.self, path: .login, method: .post, parameters: loginRequestModel).showMessage(toastManager)
            }

            if response.isSuccess, let data = response.data {
                authStore.authState = .authenticated(data)
            }
        }
    }
}

private extension RegisterTabView {
    func register() {
        focusedField = nil
        var errorMessages: [String] = []

        if password != confirmPassword {
            errorMessages.append("L.PasswordsDoNotMatch")
        }

        if !email.isValidEmail {
            errorMessages.append("L.InvalidEmail")
        }

        if errorMessages.count > 0 {
            toastManager.showToast(ECToast(style: .error, message: errorMessages.joined(separator: "\n")))
            return
        }

        Task {
            let registerRequestModel = RegisterRequestModel(
                name: name,
                surname: surname,
                email: email,
                phoneCode: phoneCode,
                phoneNumber: phoneNumber,
                username: username,
                password: password
            )

            let response = await withLoader(loader: loader) {
                await networkManager
                    .request(UserModel.self, path: .register, method: .post, parameters: registerRequestModel)
                    .showMessage(toastManager)
            }

            if response.isSuccess {
                let loginRequestModel = LoginRequestModel(username: username, password: password)

                let loginResponse = await withLoader(loader: loader) {
                    await networkManager
                        .request(LoginResponseModel.self, path: .login, method: .post, parameters: loginRequestModel)
                        .showMessage(toastManager)
                }

                if loginResponse.isSuccess, let data = loginResponse.data {
                    authStore.authState = .authenticated(data)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
            .environment(\.networkManager, NetworkManager(baseURL: "", loader: ECLoader(), authStore: AuthStore(), userDefaultsManager: UserDefaultsManager()))
            .environment(ToastManager())
            .environment(\.rootNavigator, Navigator())
            .environment(ECLoader())
            .environment(\.userDefaultsManager, UserDefaultsManager())
            .environment(AuthStore())
    }
}
