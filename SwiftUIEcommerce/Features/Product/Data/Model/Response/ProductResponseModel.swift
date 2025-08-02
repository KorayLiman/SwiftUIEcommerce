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

    init(id: Int? = nil,
         createdDate: String? = nil,
         lastModifiedDate: String? = nil,
         name: String? = nil,
         description: String? = nil,
         price: Double? = nil,
         imageFile: ImageFileModel? = nil,
         category: CategoryResponseModel? = nil)
    {
        self.id = id
        self.createdDate = createdDate
        self.lastModifiedDate = lastModifiedDate

        self.name = name
        self.description = description
        self.price = price
        self.imageFile = imageFile
        self.category = category
    }
}
