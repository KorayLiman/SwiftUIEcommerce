//
//  ForgotPasswordScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 20.07.2025.
//

import SwiftUI

struct ForgotPasswordScreen: View {
    @FocusState private var focusedField: Field?
    @State private var viewModel = ForgotPasswordViewModel()

    var body: some View {
        VStack(spacing: 16) {
            @Bindable var viewModelBindable = viewModel
            ECText(localizedStringKey: "L.ForgotPasswordDescriptionText")
                .ecTextColor(.secondary)
                .font(.body)
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
            HStack {
                ECTextField(text: $viewModelBindable.phoneCode)
                    .keyboardType(.phonePad)
                    .submitLabel(.next)
                    .frame(minWidth: 80)
                    .onChange(of: viewModel.phoneCode) { _, newValue in
                        let digits = newValue.filter { $0.isNumber }.prefix(2)
                        viewModel.phoneCode = "+" + digits
                    }
                    .onAppear {
                        let digits = viewModel.phoneCode.filter { $0.isNumber }.prefix(2)
                        viewModel.phoneCode = "+" + digits
                    }
                    .focused($focusedField, equals: .phoneCode)

                ECTextField(placeholder: "L.PhoneNumber", text: $viewModelBindable.phoneNumber)
                    .keyboardType(.phonePad)
                    .textContentType(.telephoneNumber)
                    .submitLabel(.next)
                    .layoutPriority(1)
                    .focused($focusedField, equals: .phoneNumber)
            }

            ECFilledButton(localizedStringKey: "L.Next") {
                focusedField = nil
                Task{
                    await viewModel.sendOtp()
                }
            }
            .ecDisabled( viewModel.phoneNumber.isEmpty || viewModel.phoneCode.isEmpty)
            .ecMaxWidth(.infinity)
          

            Spacer()
        }

        .padding(.all, 24)
        .navigationTitle("L.ForgotPassword")
    }
}

#Preview {
    NavigationStack {}
}
