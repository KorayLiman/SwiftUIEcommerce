//
//  ForgotPasswordRemoteDS.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

protocol IForgotPasswordRemoteDS {
    func sendOtpCode(requestModel: SendOtpCodeRequestModel) async -> BaseResponse<NullData>
}

final class ForgotPasswordRemoteDS: BaseRemoteDS, IForgotPasswordRemoteDS {
    func sendOtpCode(requestModel: SendOtpCodeRequestModel) async -> BaseResponse<NullData> {
        await networkManager.request(path: .sendOtpCode, method: .post,
                                     parameters: requestModel)
    }
}
