//
//  ProductListRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

protocol IProductListRepository {
    func getProductCategories() async -> BaseResponse<[CategoryResponseModel]>
    func getAllProducts() async -> BaseResponse<[ProductResponseModel]>
    func getProductsByCategoryId(_ categoryId: Int) async -> BaseResponse<[ProductResponseModel]>
}

final class ProductListRepository: IProductListRepository {
    private let productListRemoteDS: IProductListRemoteDS

    init(productListRemoteDS: IProductListRemoteDS) {
        self.productListRemoteDS = productListRemoteDS
    }

    func getProductCategories() async -> BaseResponse<[CategoryResponseModel]> {
        await productListRemoteDS.getProductCategories()
    }

    func getAllProducts() async -> BaseResponse<[ProductResponseModel]> {
        await productListRemoteDS.getAllProducts()
    }

    func getProductsByCategoryId(_ categoryId: Int) async -> BaseResponse<[ProductResponseModel]> {
        await productListRemoteDS.getProductsByCategoryId(categoryId)
    }
}
