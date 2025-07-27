//
//  LoginRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

protocol ILoginRepository {
    func login(request: LoginRequestModel) async -> LoginResponseModel?
    func register(request: RegisterRequestModel) async -> Bool
}

final class LoginRepository: ILoginRepository {
    init(loginRemoteDS: ILoginRemoteDS) {
        self.loginRemoteDS = loginRemoteDS
    }

    private let loginRemoteDS: ILoginRemoteDS
    func login(request: LoginRequestModel) async -> LoginResponseModel? {
        await withLoader {
            await self.loginRemoteDS.login(request: request).showMessage()
        }.data
    }

    func register(request: RegisterRequestModel) async -> Bool {
        await withLoader {
            await self.loginRemoteDS.register(request: request).showMessage()
        }.isSuccess
    }
}
