//
//  ResetPasswordRemoteDS.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

protocol IResetPasswordRemoteDS {
    func resetPassword(request: ResetPasswordRequestModel) async -> BaseResponse<NullData>
}

final class ResetPasswordRemoteDS: BaseRemoteDS, IResetPasswordRemoteDS {
    func resetPassword(request: ResetPasswordRequestModel) async -> BaseResponse<NullData> {
        await networkManager.request(path: .forgotPassword, method: .post, parameters: request)
    }
}
