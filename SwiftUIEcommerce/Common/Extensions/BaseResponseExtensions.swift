//
//  BaseResponseExtensions.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 18.07.2025.
//

import SwiftUI

extension BaseResponse {
    func showMessage(_ toastManager: ToastManager) -> Self {
        if messages == nil {
            if error != nil {
                toastManager.showToast(ECToast(style: .error, message: error!.localizedDescription))
            }
        }
        else {
            if messages!.count > 0 {
                let joinedMessages = messages!.joined(separator: "\n")
                toastManager.showToast(ECToast(style: .info, message: joinedMessages))
            }
        }
        return self
    }
}
