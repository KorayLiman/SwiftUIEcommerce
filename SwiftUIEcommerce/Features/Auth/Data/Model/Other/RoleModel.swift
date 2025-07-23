//
//  RoleModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 16.07.2025.
//

struct RoleModel: Codable, Equatable {
    let name: String?

    static func == (lhs: RoleModel, rhs: RoleModel) -> Bool {
        return lhs.name == rhs.name
    }
}
