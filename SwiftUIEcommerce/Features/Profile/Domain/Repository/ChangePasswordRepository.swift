//
//  ChangePasswordRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 11.08.2025.
//

protocol IChangePasswordRepository {
    func changePassword(request: ChangePasswordRequestModel) async -> BaseResponse<NullData>
}

final class ChangePasswordRepository: IChangePasswordRepository {
    init(changePasswordRemoteDS: IChangePasswordRemoteDS) {
        self.changePasswordRemoteDS = changePasswordRemoteDS
    }
    
    private let changePasswordRemoteDS: IChangePasswordRemoteDS
    
    func changePassword(request: ChangePasswordRequestModel) async -> BaseResponse<NullData> {
        await self.changePasswordRemoteDS.changePassword(request: request)
    }
}
    
