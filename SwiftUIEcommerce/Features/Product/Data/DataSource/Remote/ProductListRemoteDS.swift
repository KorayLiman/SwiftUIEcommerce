//
//  ProductListRemoteDS.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

protocol IProductListRemoteDS {
    func getProductCategories() async -> BaseResponse<[CategoryResponseModel]>
    func getAllProducts() async -> BaseResponse<[ProductResponseModel]>
    func getProductsByCategoryId(_ categoryId: Int) async -> BaseResponse<[ProductResponseModel]>
        
}

final class ProductListRemoteDS: BaseRemoteDS, IProductListRemoteDS {
    func getProductCategories() async -> BaseResponse<[CategoryResponseModel]> {
        await networkManager.request([CategoryResponseModel].self, path: .category, method: .get)
    }

    func getAllProducts() async -> BaseResponse<[ProductResponseModel]> {
        await networkManager.request([ProductResponseModel].self, path: .product, method: .get)
    }
    
    func getProductsByCategoryId(_ categoryId: Int) async -> BaseResponse<[ProductResponseModel]> {
        await networkManager.request([ProductResponseModel].self, path: .productByCategoryId(id: categoryId), method: .get)
    }
}
