//
//  ECTextField.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 14.07.2025.
//

import SwiftUI

struct ECTextField: View {
    var icon: String?
    var placeholder: LocalizedStringKey?
    @Binding var text: String
    var isSecure: Bool
    @State private var isTextVisible: Bool = false

    init(icon: String? = nil, placeholder: LocalizedStringKey? = nil, text: Binding<String>, isSecure: Bool = false) {
        self.icon = icon
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
    }

    var body: some View {
        HStack {
            if icon != nil {
                Image(systemName: icon!)
                    .foregroundColor(.secondary)
                    .padding(.leading, 12)
                    .frame(width: 24)
            }
            Group {
                if isSecure && !isTextVisible {
                    SecureField(placeholder ?? "", text: $text)
                     

                } else {
                    TextField(placeholder ?? "", text: $text)
                }
            }
            .padding(.all, 12)
            .autocorrectionDisabled(true)

            if isSecure {
                Button(action: {
                    isTextVisible.toggle()

                }) {
                    Image(systemName: isTextVisible ? "eye" : "eye.slash")
                        .foregroundColor(.secondary)
                }
                .padding(.trailing, 12)
            }
        }
        .background(.ecBackgroundVariant2)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    @Previewable @State var text = "John Doe"

    return VStack(spacing: 20) {
        ECTextField(icon: "person", placeholder: "Username", text: $text)
        ECTextField(icon: "lock", placeholder: "Password", text: $text, isSecure: true)
    }
    .padding()
}
