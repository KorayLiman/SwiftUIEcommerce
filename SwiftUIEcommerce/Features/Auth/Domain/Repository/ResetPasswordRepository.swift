//
//  ResetPasswordRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

protocol IResetPasswordRepository {
    func resetPassword(request: ResetPasswordRequestModel) async -> Bool
}

final class ResetPasswordRepository: IResetPasswordRepository {
    init(resetPasswordRemoteDS: ResetPasswordRemoteDS) {
        self.resetPasswordRemoteDS = resetPasswordRemoteDS
    }

    private let resetPasswordRemoteDS: ResetPasswordRemoteDS
    func resetPassword(request: ResetPasswordRequestModel) async -> Bool {
        await withLoader {
            await self.resetPasswordRemoteDS.resetPassword(request: request).showMessage()
        }.isSuccess
    }
}
