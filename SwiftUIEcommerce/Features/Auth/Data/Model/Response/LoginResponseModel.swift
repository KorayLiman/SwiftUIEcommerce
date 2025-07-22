//
//  LoginResponseModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 16.07.2025.
//

final class LoginResponseModel: Codable, Equatable {
    let accessToken: String?
    let refreshToken: String?
    let user: UserModel?
    let privacyAgreementHasBeenApproved: Bool?
    let userAgreementHasBeenApproved: Bool?

    static func == (lhs: LoginResponseModel, rhs: LoginResponseModel) -> Bool {
        return lhs.accessToken == rhs.accessToken &&
            lhs.refreshToken == rhs.refreshToken &&
            lhs.user == rhs.user &&
            lhs.privacyAgreementHasBeenApproved == rhs.privacyAgreementHasBeenApproved &&
            lhs.userAgreementHasBeenApproved == rhs.userAgreementHasBeenApproved
    }
}
