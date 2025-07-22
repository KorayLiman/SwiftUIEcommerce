//
//  SendOtpCodeRequestModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 22.07.2025.
//

struct SendOtpCodeRequestModel: Codable {
    let phoneCode: String
    let phoneNumber: String
    let purpose: String

    init(phoneCode: String, phoneNumber: String, purpose: String = "FORGOT_PASSWORD") {
        self.phoneCode = phoneCode
        self.phoneNumber = phoneNumber
        self.purpose = purpose
    }
}
