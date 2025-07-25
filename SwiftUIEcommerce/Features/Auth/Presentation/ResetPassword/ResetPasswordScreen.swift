//
//  ResetPasswordScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 22.07.2025.
//

import SwiftUI

struct ResetPasswordScreen: View {
    @State private var otpCode: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @FocusState private var focusedField: Field?
    @Environment(\.networkManager) private var networkManager
    @Environment(ECLoader.self) private var loader
    @Environment(ToastManager.self) private var toastManager
    @Environment(\.rootNavigator) private var rootNavigator

    private let phoneCode: String
    private let phoneNumber: String

    init(phoneCode: String, phoneNumber: String) {
        self.phoneCode = phoneCode
        self.phoneNumber = phoneNumber
    }

    var body: some View {
        VStack(spacing: 16) {
            ECText(localizedStringKey: "L.ResetPasswordDescriptionText", foregroundColor: .secondary, font: .body)

                .multilineTextAlignment(.center)
                .fontWeight(.semibold)

            ECTextField(icon: "lock.circle", placeholder: "L.Code", text: $otpCode)
                .keyboardType(.numberPad)
                .submitLabel(.next)
                .focused($focusedField, equals: .otpCode)

            ECTextField(icon: "lock", placeholder: "L.NewPassword", text: $password, isSecure: true)
                .submitLabel(.next)
                .textContentType(.password)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .password)
                .onSubmit {
                    focusedField = .confirmPassword
                }

            ECTextField(icon: "lock", placeholder: "L.ConfirmNewPassword", text: $confirmPassword, isSecure: true)
                .submitLabel(.done)
                .textContentType(.password)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .confirmPassword)
                .padding(.bottom, 8)

            ECFilledButton(localizedStringKey: "L.Confirm", maxWidth: .infinity) {
                resetPassword()
            }.disabled(otpCode == "" || password == "" || confirmPassword != password)

            Spacer()
        }
        .padding(.all, 24)
        .navigationTitle("L.ResetPassword")
    }
}

private extension ResetPasswordScreen {
    func resetPassword() {
        focusedField = nil
        let resetPasswordRequestModel = ResetPasswordRequestModel(phoneCode: phoneCode, phoneNumber: phoneNumber, code: otpCode, newPassword: password)

        Task {
            let response = await withLoader(loader: loader) {
                await networkManager.request(path: .forgotPassword, method: .post, parameters: resetPasswordRequestModel).showMessage(toastManager)
            }

            if response.isSuccess {
                rootNavigator.popToRoot()
            }
        }
    }
}

#Preview {
    NavigationStack {
        ResetPasswordScreen(
            phoneCode: "", phoneNumber: ""
        )
        .environment(\.networkManager, NetworkManager(baseURL: "", loader: ECLoader(), authStore: AuthStore(), userDefaultsManager: UserDefaultsManager()))
        .environment(ECLoader())
        .environment(ToastManager())
        .environment(\.rootNavigator, Navigator())
    }
}
