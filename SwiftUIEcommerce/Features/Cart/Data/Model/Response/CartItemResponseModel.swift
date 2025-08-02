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

    init(id: Int? = nil, createdDate: String? = nil, lastModifiedDate: String? = nil, product: ProductResponseModel? = nil) {
        self.id = id
        self.createdDate = createdDate
        self.lastModifiedDate = lastModifiedDate
        self.product = product
    }
}
