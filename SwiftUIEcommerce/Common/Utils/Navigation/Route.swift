//
//  Route.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 13.07.2025.
//



enum Route: Hashable {
    case forgotPassword
    case productList
    case productDetail
    case resetPassword(phoneCode: String, phoneNumber: String)
}

enum CartRoute: Hashable {
    case placeOrder
}
