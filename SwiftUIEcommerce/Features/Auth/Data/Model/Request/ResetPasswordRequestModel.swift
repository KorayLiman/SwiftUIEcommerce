//
//  ResetPasswordRequestModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

struct ResetPasswordRequestModel: Codable {
    let phoneCode: String
    let phoneNumber: String
    let code: String
    let newPassword: String
}
