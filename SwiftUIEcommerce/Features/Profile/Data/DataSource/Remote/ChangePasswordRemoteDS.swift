//
//  ChangePasswordRemoteDS.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 11.08.2025.
//

protocol IChangePasswordRemoteDS {
    func changePassword(request: ChangePasswordRequestModel) async -> BaseResponse<NullData>
}

final class ChangePasswordRemoteDS: BaseRemoteDS, IChangePasswordRemoteDS {
    func changePassword(request: ChangePasswordRequestModel) async -> BaseResponse<NullData> {
        await networkManager.request(path: .changePassword, method: .post, parameters: request)
    }
}
