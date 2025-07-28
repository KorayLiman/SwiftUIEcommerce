//
//  ECToast.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 17.07.2025.
//

import SwiftUI

struct ECToast: Equatable {
    var style: ToastStyle
    var message: String
    var duration: Double = 3
}

struct ECToastView: View {
    let toast: ECToast
   
    
    private var toastManager: ToastManager{
        DIContainer.shared.synchronizedResolver.resolve(ToastManager.self)!
    }

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: toast.style.iconFileName)
                .foregroundColor(toast.style.themeColor)
            ECText(label: toast.message)
            
                .font(.subheadline)
                .foregroundColor(.black)

            Spacer(minLength: 10)

            Button {
                toastManager.hideToast()
               
            } label: {
                Image(systemName: "xmark")
                    .foregroundColor(toast.style.themeColor)
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(.ecBackgroundVariant)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(toast.style.themeColor, lineWidth: 1.5)
        )
        .padding(.horizontal, 16)
    }
}

#Preview {
    ECToastView(toast: ECToast(style: .success, message: "This is a success message"))
}
