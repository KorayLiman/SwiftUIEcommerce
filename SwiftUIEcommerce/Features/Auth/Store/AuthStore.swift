//
//  AuthStore.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 13.07.2025.
//

import Observation

@Observable
final class AuthStore {
    var authState: AuthState = .unknown
}
