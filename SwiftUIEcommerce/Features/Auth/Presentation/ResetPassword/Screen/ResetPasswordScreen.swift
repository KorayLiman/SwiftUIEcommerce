//
//  ResetPasswordScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 22.07.2025.
//

import SwiftUI

struct ResetPasswordScreen: View {
    @State private var viewModel = ResetPasswordViewModel()
    @FocusState private var focusedField: Field?

    private let phoneCode: String
    private let phoneNumber: String

    init(phoneCode: String, phoneNumber: String) {
        self.phoneCode = phoneCode
        self.phoneNumber = phoneNumber
    }

    var body: some View {
        VStack(spacing: 16) {
            @Bindable var viewModelBindable = viewModel
            ECText(localizedStringKey: "L.ResetPasswordDescriptionText")
                .ecTextColor(.secondary)
                .font(.body)

                .multilineTextAlignment(.center)
                .fontWeight(.semibold)

            ECTextField(icon: "lock.circle", placeholder: "L.Code", text: $viewModelBindable.otpCode)
                .keyboardType(.numberPad)
                .submitLabel(.next)
                .focused($focusedField, equals: .otpCode)

            ECTextField(icon: "lock", placeholder: "L.NewPassword", text: $viewModelBindable.password, isSecure: true)
                .submitLabel(.next)
                .textContentType(.password)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .password)
                .onSubmit {
                    focusedField = .confirmPassword
                }

            ECTextField(icon: "lock", placeholder: "L.ConfirmNewPassword", text: $viewModelBindable.confirmPassword, isSecure: true)
                .submitLabel(.done)
                .textContentType(.password)
                .textInputAutocapitalization(.never)
                .focused($focusedField, equals: .confirmPassword)
                .padding(.bottom, 8)

            ECFilledButton(localizedStringKey: "L.Confirm") {
                focusedField = nil
                Task{
                    await   viewModel.resetPassword(phoneCode: phoneCode, phoneNumber: phoneNumber)
                }
            }
            .ecDisabled( viewModel.otpCode == "" || viewModel.password == "" || viewModel.confirmPassword != viewModel.password)
            .ecMaxWidth(.infinity)

            Spacer()
        }
            .padding(.all, 24)
            .navigationTitle("L.ResetPassword")
    }
}

#Preview {
    NavigationStack {
        ResetPasswordScreen(
            phoneCode: "", phoneNumber: ""
        )
    }
}
