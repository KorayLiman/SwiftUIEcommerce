//
//  AuthRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

import Combine

protocol IAuthRepository {
    var authStateStream: PassthroughSubject<AuthState, Never> { get }
}

final class AuthRepository: IAuthRepository {
    let authStateStream = PassthroughSubject<AuthState, Never>()
}
