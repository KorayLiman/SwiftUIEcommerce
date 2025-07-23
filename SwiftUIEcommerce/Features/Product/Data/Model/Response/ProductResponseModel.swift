//
//  ProductResponseModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

struct ProductResponseModel: Codable, Equatable, Hashable {
    let id: Int?
    let createdDate: String?
    let lastModifiedDate: String?
    let name: String?
    let description: String?
    let price: Double?
    let imageFile: ImageFileModel?
    let category: CategoryResponseModel?
}
