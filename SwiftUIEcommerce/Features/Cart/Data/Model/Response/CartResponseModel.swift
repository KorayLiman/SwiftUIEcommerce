//
//  CartResponseModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

struct CartResponseModel: Codable {
    let id: String?
    let createdDate: String?
    let lastModifiedDate: String?
    let product: ProductResponseModel?
}
