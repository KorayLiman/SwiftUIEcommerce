//
//  ProductListRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

protocol IProductListRepository {
    func getProductCategories() async -> [CategoryResponseModel]?
    func getAllProducts() async -> [ProductResponseModel]?
    func getProductsByCategoryId(_ categoryId: Int) async -> [ProductResponseModel]?
}

final class ProductListRepository: IProductListRepository {
    private let productListRemoteDS: IProductListRemoteDS

    init(productListRemoteDS: IProductListRemoteDS) {
        self.productListRemoteDS = productListRemoteDS
    }

    func getProductCategories() async -> [CategoryResponseModel]? {
         await productListRemoteDS.getProductCategories().showMessage().data
    }
    func getAllProducts() async -> [ProductResponseModel]? {
         await productListRemoteDS.getAllProducts().showMessage().data
    }
    func getProductsByCategoryId(_ categoryId: Int) async -> [ProductResponseModel]? {
        await productListRemoteDS.getProductsByCategoryId(categoryId).showMessage().data
    }
}
