//
//  LoginResponseModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 16.07.2025.
//

struct LoginResponseModel: Codable, Equatable {
    let accessToken: String?
    let refreshToken: String?
    let user: UserModel?
    let privacyAgreementHasBeenApproved: Bool?
    let userAgreementHasBeenApproved: Bool?

  
}
