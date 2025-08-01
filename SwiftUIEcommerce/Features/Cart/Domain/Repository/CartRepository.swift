//
//  CartRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 28.07.2025.
//

protocol ICartRepository {
    func addToCart(_ request: AddToCartRequestModel) async -> BaseResponse<CartItemResponseModel>
    func removeFromCart(_ requestModel: RemoveFromCartRequestModel) async -> BaseResponse<NullData>
    func getCartItems() async -> BaseResponse<[CartItemResponseModel]>
}

final class CartRepository: ICartRepository {
    init(cartRemoteDS: ICartRemoteDS) {
        self.cartRemoteDS = cartRemoteDS
    }

    private let cartRemoteDS: ICartRemoteDS

    func addToCart(_ request: AddToCartRequestModel) async -> BaseResponse<CartItemResponseModel> {
        await self.cartRemoteDS.addToCart(request)
    }

    func getCartItems() async -> BaseResponse<[CartItemResponseModel]> {
        await self.cartRemoteDS.getCartItems()
    }
    func removeFromCart(_ requestModel: RemoveFromCartRequestModel) async -> BaseResponse<NullData> {
        await self.cartRemoteDS.removeFromCart(requestModel)
    }
}
