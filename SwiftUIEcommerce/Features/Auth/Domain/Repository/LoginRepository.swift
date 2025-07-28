//
//  LoginRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

protocol ILoginRepository {
    func login(request: LoginRequestModel) async -> BaseResponse<LoginResponseModel>
    func register(request: RegisterRequestModel) async -> BaseResponse<UserModel>
}

final class LoginRepository: ILoginRepository {
    init(loginRemoteDS: ILoginRemoteDS) {
        self.loginRemoteDS = loginRemoteDS
    }

    private let loginRemoteDS: ILoginRemoteDS
    func login(request: LoginRequestModel) async -> BaseResponse<LoginResponseModel> {
        await self.loginRemoteDS.login(request: request)
    }

    func register(request: RegisterRequestModel) async -> BaseResponse<UserModel> {
        await self.loginRemoteDS.register(request: request)
    }
}
