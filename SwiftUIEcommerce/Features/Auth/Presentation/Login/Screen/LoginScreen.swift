//
//  LoginView.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 10.07.2025.
//

import Alamofire
import SwiftUI

struct LoginScreen: View {
    @State private var viewModel = LoginViewModel()
    @Namespace private var buttonId

    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                ForEach(viewModel.tabs.indices, id: \.self) { index in
                    VStack(spacing: 4) {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                viewModel.selectedTab = index
                            }
                        }) {
                            ECText(localizedStringKey: LocalizedStringKey(viewModel.tabs[index]), foregroundColor: viewModel.selectedTab == index ? .ecAccent : .secondary, font: .headline)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        .contentShape(Rectangle())

                        Group {
                            if viewModel.selectedTab == index {
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

            TabView(selection: $viewModel.selectedTab) {
                LoginTabView()
                    .tag(0)

                RegisterTabView()
                    .tag(1)
            }
            .padding()
            .animation(.default, value: viewModel.selectedTab)
        }
        .navigationTitle(Text(verbatim: "SwiftUI Ecommerce"))
        .padding(.horizontal)
        .environment(viewModel)
    }
}

private struct LoginTabView: View {
    @Environment(LoginViewModel.self) private var viewModel
    @FocusState private var focusedField: Field?

    var body: some View {
        ECScrollView {
            VStack(spacing: 12) {
                @Bindable var viewModelBindable = viewModel
                ECTextField(icon: "person", placeholder: "L.Username", text: $viewModelBindable.usernameLogin)
                    .focused($focusedField, equals: .username)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }
                    .textInputAutocapitalization(.never)
                    .textContentType(.username)

                ECTextField(icon: "lock", placeholder: "L.Password", text: $viewModelBindable.passwordLogin, isSecure: true)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.done)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)

                HStack {
                    Spacer()
                    ECTextButton(localizedStringKey: "L.ForgotPassword") {
                        viewModel.goToForgotPassword()
                    }
                }

                ECFilledButton(localizedStringKey: "L.Login", maxWidth: .infinity, disabled: viewModel.usernameLogin.isEmpty || viewModel.passwordLogin.isEmpty) {
                    focusedField = nil
                    Task {
                        await viewModel.login()
                    }
                }
            }
        }
    }
}

private struct RegisterTabView: View {
    @FocusState private var focusedField: Field?
    @Environment(LoginViewModel.self) private var viewModel

    var body: some View {
        ECScrollView {
            VStack(spacing: 12) {
                @Bindable var viewModelBindable = viewModel
                HStack {
                    ECTextField(text: $viewModelBindable.phoneCodeRegister)
                        .keyboardType(.phonePad)
                        .submitLabel(.next)
                        .frame(minWidth: 80)
                        .onChange(of: viewModelBindable.phoneCodeRegister) { _, newValue in
                            let digits = newValue.filter { $0.isNumber }.prefix(2)
                            viewModelBindable.phoneCodeRegister = "+" + digits
                        }
                        .onAppear {
                            let digits = viewModelBindable.phoneCodeRegister.filter { $0.isNumber }.prefix(2)
                            viewModelBindable.phoneCodeRegister = "+" + digits
                        }
                        .focused($focusedField, equals: .phoneCode)

                    ECTextField(placeholder: "L.PhoneNumber", text: $viewModelBindable.phoneNumberRegister)
                        .keyboardType(.phonePad)
                        .textContentType(.telephoneNumber)
                        .submitLabel(.next)
                        .layoutPriority(1)
                        .focused($focusedField, equals: .phoneNumber)
                }
                ECTextField(icon: "person", placeholder: "L.Username", text: $viewModelBindable.usernameRegister)
                    .keyboardType(.default)
                    .textContentType(.username)
                    .textInputAutocapitalization(.never)
                    .submitLabel(.next)
                    .focused($focusedField, equals: .username)
                    .onSubmit {
                        focusedField = .password
                    }
                ECTextField(icon: "lock", placeholder: "L.Password", text: $viewModelBindable.passwordRegister, isSecure: true)
                    .submitLabel(.next)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .password)
                    .onSubmit {
                        focusedField = .confirmPassword
                    }

                ECTextField(icon: "lock", placeholder: "L.ConfirmPassword", text: $viewModelBindable.confirmPasswordRegister, isSecure: true)
                    .submitLabel(.next)
                    .textContentType(.password)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .confirmPassword)
                    .onSubmit {
                        focusedField = .name
                    }

                ECTextField(icon: "person", placeholder: "L.Name", text: $viewModelBindable.nameRegister)
                    .submitLabel(.next)
                    .keyboardType(.default)
                    .textContentType(.name)
                    .textInputAutocapitalization(.words)
                    .focused($focusedField, equals: .name)
                    .onSubmit {
                        focusedField = .surname
                    }

                ECTextField(icon: "person", placeholder: "L.Surname", text: $viewModelBindable.surnameRegister)
                    .submitLabel(.next)
                    .keyboardType(.default)
                    .textContentType(.familyName)
                    .textInputAutocapitalization(.words)
                    .focused($focusedField, equals: .surname)
                    .onSubmit {
                        focusedField = .email
                    }

                ECTextField(icon: "envelope", placeholder: "L.Email", text: $viewModelBindable.emailRegister)
                    .submitLabel(.done)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .focused($focusedField, equals: .email)

                Group {
                    ECSwitch(isOn: $viewModelBindable.isUserAgreementAcceptedRegister) {
                        ECText(localizedStringKey: "L.UserAgreement")
                    }

                    ECSwitch(isOn: $viewModelBindable.isPrivacyPolicyAcceptedRegister) {
                        ECText(localizedStringKey: "L.PrivacyPolicy")
                    }
                }.padding(.horizontal, 12)

                ECFilledButton(localizedStringKey: "L.Register", maxWidth: .infinity, disabled: viewModel.phoneCodeRegister.isEmpty || viewModel.phoneNumberRegister.isEmpty || viewModel.usernameRegister.isEmpty || viewModel.passwordRegister.isEmpty || viewModel.confirmPasswordRegister.isEmpty || viewModel.nameRegister.isEmpty || viewModel.surnameRegister.isEmpty || viewModel.emailRegister.isEmpty || !viewModel.isUserAgreementAcceptedRegister || !viewModel.isPrivacyPolicyAcceptedRegister) {
                    focusedField = nil
                    Task{
                        await  viewModel.register()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginScreen()
    }
}
