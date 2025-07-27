//
//  LoginDatSource.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

protocol ILoginRemoteDS {
    func login(request: LoginRequestModel) async -> BaseResponse<LoginResponseModel>
    func register(request: RegisterRequestModel) async -> BaseResponse<UserModel>
}

final class LoginRemoteDS: BaseRemoteDS, ILoginRemoteDS {
    func login(request: LoginRequestModel) async -> BaseResponse<LoginResponseModel> {
        await networkManager.request(LoginResponseModel.self, path: .login, method: .post, parameters: request)
    }

    func register(request: RegisterRequestModel) async -> BaseResponse<UserModel> {
        await networkManager
            .request(UserModel.self, path: .register, method: .post, parameters: request)
    }
}
