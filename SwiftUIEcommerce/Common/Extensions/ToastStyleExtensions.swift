//
//  ToastStyleExtensions.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 17.07.2025.
//

import SwiftUI

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return .red
        case .warning: return .orange
        case .info: return .blue
        case .success: return .green
        }
    }

    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}
