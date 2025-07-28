//
//  CartResponseModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

struct CartItemResponseModel: Codable {
    let id: Int?
    let createdDate: String?
    let lastModifiedDate: String?
    let product: ProductResponseModel?
}
