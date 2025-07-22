//
//  AuthState.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 10.07.2025.
//

enum AuthState: Equatable {
    case unknown
    case authenticated(LoginResponseModel)
    case unAuthenticated

    static func == (lhs: AuthState, rhs: AuthState) -> Bool {
        switch (lhs, rhs) {
        case (.unknown, .unknown):
            return true
        case (.authenticated(let user1), .authenticated(let user2)):
            return user1 == user2
        case (.unAuthenticated, .unAuthenticated):
            return true
        default:
            return false
        }
    }
}
