//
//  ForgotPasswordRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

protocol IForgotPasswordRepository {
    func sendOtp(requestModel: SendOtpCodeRequestModel) async -> BaseResponse<NullData>
}

final class ForgotPasswordRepository: IForgotPasswordRepository {
    init(forgotPasswordRemoteDS: IForgotPasswordRemoteDS) {
        self.forgotPasswordRemoteDS = forgotPasswordRemoteDS
    }

    private let forgotPasswordRemoteDS: IForgotPasswordRemoteDS

    func sendOtp(requestModel: SendOtpCodeRequestModel) async -> BaseResponse<NullData> {
        await self.forgotPasswordRemoteDS.sendOtpCode(requestModel: requestModel)
        
    }
}
