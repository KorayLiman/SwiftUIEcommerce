//
//  ForgotPasswordScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 20.07.2025.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    @State private var phoneCode: String = "+90"
    @State private var phoneNumber: String = ""
    @FocusState private var focusedField: Field?
    @Environment(\.networkManager) private var networkManager
    @Environment(ToastManager.self) private var toastManager
    @Environment(\.rootNavigator) private var navigator
    @Environment(ECLoader.self) private var loader

    var body: some View {
        VStack(spacing: 16) {
            ECText(localizedStringKey: "L.ForgotPasswordDescriptionText", foregroundColor: .secondary, font: .body)
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
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

            ECFilledButton(localizedStringKey: "L.Next", maxWidth: .infinity) {
                sendOtpCode()
            }
            .disabled(phoneNumber.isEmpty || phoneCode.isEmpty)

            Spacer()
        }
        .padding(.all, 24)
        .navigationTitle("L.ForgotPassword")
        
    }
}

private extension ForgotPasswordScreen {
    func sendOtpCode() {
        focusedField = nil
        Task {
            let sendOtpCodeRequestModel = SendOtpCodeRequestModel(phoneCode: phoneCode, phoneNumber: phoneNumber)
            let res = await withLoader(loader: loader) {
                await networkManager.request(path: .sendOtpCode, method: .post,
                                             parameters: sendOtpCodeRequestModel).showMessage(toastManager)
            }

            if res.isSuccess {
                navigator.replaceCurrent(.resetPassword(phoneCode: phoneCode, phoneNumber: phoneNumber))
            }
        }
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordScreen()
            .environment(\.networkManager, NetworkManager(baseURL: "", loader: ECLoader(), authStore: AuthStore(), userDefaultsManager: UserDefaultsManager()))
            .environment(ToastManager())
            .environment(\.rootNavigator, Navigator())
            .environment(ECLoader())
    }
}
