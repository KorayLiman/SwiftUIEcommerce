//
//  UserModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 16.07.2025.
//

struct UserModel: Codable, Equatable {
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
}
