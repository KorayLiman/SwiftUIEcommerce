//
//  CartRemoteDS.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 28.07.2025.
//

protocol ICartRemoteDS {
    func addToCart(_ requestModel: AddToCartRequestModel) async -> BaseResponse<NullData>
    func getCartItems() async -> BaseResponse<[CartItemResponseModel]>
}

final class CartRemoteDS: BaseRemoteDS, ICartRemoteDS {
    func addToCart(_ requestModel: AddToCartRequestModel) async -> BaseResponse<NullData> {
        await networkManager.request(path: .cartItem, method: .post, parameters: requestModel)
    }

    func getCartItems() async -> BaseResponse<[CartItemResponseModel]> {
        await networkManager.request([CartItemResponseModel].self, path: .cartItem, method: .get)
    }
}
