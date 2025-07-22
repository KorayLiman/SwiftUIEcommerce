//
//  UserModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 16.07.2025.
//

final class UserModel: Codable, Equatable {
    let id: Int?
    let name: String?
    let surname: String?
    let email: String?
    let phoneCode: String?
    let phoneNumber: String?
    let username: String?
    let createdDate: String?
    let lastModifiedDate: String?
    let roles: [RoleModel]?

    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.surname == rhs.surname &&
            lhs.email == rhs.email &&
            lhs.phoneCode == rhs.phoneCode &&
            lhs.phoneNumber == rhs.phoneNumber &&
            lhs.username == rhs.username &&
            lhs.createdDate == rhs.createdDate &&
            lhs.lastModifiedDate == rhs.lastModifiedDate &&
            lhs.roles == rhs.roles
    }
}
