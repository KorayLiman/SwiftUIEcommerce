//
//  RequestPath.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 16.07.2025.
//

enum RequestPath {
    case login
    case register
    case sendOtpCode
    case forgotPassword
    case category
    case product
    case productByCategoryId(id: Int)
    case file(id: Int)
    case fileByte(id: Int)
    case cartItem

    var rawValue: String {
        switch self {
        case .login:
            return "auth/login"
        case .register:
            return "auth/register"
        case .sendOtpCode:
            return "auth/send-otp-code"
        case .forgotPassword:
            return "auth/forgot-password"
        case .category:
            return "category"
        case .product:
            return "product"
        case .productByCategoryId(let id):
            return "product/by-category-id/\(id)"
        case .file(let id):
            return "file/\(id)"
        case .fileByte(let id):
            return "file/byte/\(id)"
        case .cartItem:
            return "cart-item"
        }
    }
}
