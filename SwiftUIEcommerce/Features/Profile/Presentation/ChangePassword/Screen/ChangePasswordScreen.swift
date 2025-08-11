//
//  ChangePasswordScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 10.08.2025.
//

import SwiftUI

struct ChangePasswordScreen: View {
    @State private var viewModel = ChangePasswordViewModel()
    var body: some View {
        ECScrollView {
            VStack {
                ECText(localizedStringKey: "L.EnterCurrentPasswordForSecurity")
                    .ecTextColor(.ecOnBackgroundVariant)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 8)

                ECTextField(placeholder: "L.CurrentPassword", text: $viewModel.currentPassword, isSecure: true)
                    .textContentType(.password)
                    .autocapitalization(.none)
                    .submitLabel(.next)

                ECText(localizedStringKey: "L.EnterNewPasswordAndConfirm")
                    .ecTextColor(.ecOnBackgroundVariant)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 8)

                ECTextField(placeholder: "L.NewPassword", text: $viewModel.newPassword, isSecure: true)
                    .textContentType(.newPassword)
                    .autocapitalization(.none)
                    .submitLabel(.next)
                    .padding(.bottom, 8)

                ECTextField(placeholder: "L.ConfirmNewPassword", text: $viewModel.confirmPassword, isSecure: true)
                    .textContentType(.newPassword)
                    .autocapitalization(.none)
                    .submitLabel(.done)
                    .padding(.bottom, 16)

                ECFilledButton(localizedStringKey: "L.ChangePassword") {
                    Task {
                        await viewModel.changePassword()
                    }
                }
                .ecMaxWidth(.infinity)
                .ecDisabled(viewModel.currentPassword.isEmpty || viewModel.newPassword.isEmpty || viewModel.confirmPassword.isEmpty || viewModel.newPassword != viewModel.confirmPassword)
            }
        }.safeAreaPadding(.vertical, 16)
            .safeAreaPadding(.horizontal, 24)
            .navigationTitle("L.ChangePassword")
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChangePasswordScreen()
}
