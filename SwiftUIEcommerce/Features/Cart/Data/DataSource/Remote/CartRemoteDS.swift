//
//  CartRemoteDS.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 28.07.2025.
//

protocol ICartRemoteDS {
    func addToCart(_ requestModel: AddToCartRequestModel) async -> BaseResponse<CartItemResponseModel>
    func removeFromCart(_ requestModel: RemoveFromCartRequestModel) async -> BaseResponse<NullData>
    func getCartItems() async -> BaseResponse<[CartItemResponseModel]>
}

final class CartRemoteDS: BaseRemoteDS, ICartRemoteDS {
    func addToCart(_ requestModel: AddToCartRequestModel) async -> BaseResponse<CartItemResponseModel> {
        await networkManager.request(CartItemResponseModel.self, path: .cartItem, method: .post, parameters: requestModel)
    }

    func getCartItems() async -> BaseResponse<[CartItemResponseModel]> {
        await networkManager.request([CartItemResponseModel].self, path: .cartItem, method: .get)
    }
    
    func removeFromCart(_ requestModel: RemoveFromCartRequestModel) async -> BaseResponse<NullData> {
        await networkManager.request(NullData.self, path: .deleteCartItem(id: requestModel.cartItemId), method: .delete)
    }
}
