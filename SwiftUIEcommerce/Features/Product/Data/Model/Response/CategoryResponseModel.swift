//
//  CategoryResponseModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

struct CategoryResponseModel: Codable, Hashable, Equatable {
    let id: Int?
    let createdDate: String?
    let lastModifiedDate: String?
    let name: String?
    
    static func all() -> CategoryResponseModel {
        CategoryResponseModel(id: nil, createdDate: nil, lastModifiedDate: nil, name: String(localized: "L.All"))
    }
}
