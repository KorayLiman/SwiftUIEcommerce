//
//  CartRepository.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 28.07.2025.
//

import Combine

protocol ICartRepository {
    func addToCart(_ request: AddToCartRequestModel) async -> BaseResponse<CartItemResponseModel>
    func removeFromCart(_ requestModel: RemoveFromCartRequestModel) async -> BaseResponse<NullData>
    func getCartItems() async -> BaseResponse<[CartItemResponseModel]>
    var cartEventStream: PassthroughSubject<CartEvent, Never> { get }
}

final class CartRepository: ICartRepository {
    
    let cartEventStream = PassthroughSubject<CartEvent, Never>()
    
    init(cartRemoteDS: ICartRemoteDS) {
        self.cartRemoteDS = cartRemoteDS
    }

    private let cartRemoteDS: ICartRemoteDS

    func addToCart(_ request: AddToCartRequestModel) async -> BaseResponse<CartItemResponseModel> {
     let result =    await self.cartRemoteDS.addToCart(request)
        if let cartItem = result.data {
            self.cartEventStream.send(.productAddedToCart(cartItem))
        }
        return result
    }

    func getCartItems() async -> BaseResponse<[CartItemResponseModel]> {
        await self.cartRemoteDS.getCartItems()
    }

    func removeFromCart(_ requestModel: RemoveFromCartRequestModel) async -> BaseResponse<NullData> {
       let result = await self.cartRemoteDS.removeFromCart(requestModel)
        if result.isSuccess{
            self.cartEventStream.send(.productRemovedFromCart(requestModel.cartItemId))
        }
        return result
    }
}

enum CartEvent{
    case productAddedToCart(CartItemResponseModel)
    case productRemovedFromCart(Int)
}

