//
//  OrderResponseModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 7.08.2025.
//

struct OrderResponseModel: Codable, Equatable, Identifiable {
    let id: Int?
    let createdDate: String?
    let lastModifiedDate: String?
    let totalAmount: Double?
    let status: String?
    let payment: PaymentResponseModel?
    let address: AddressResponseModel?
    let orderNote: String?
    let user: UserModel?
    let cartItems: [CartItemResponseModel]?
}

struct PaymentResponseModel: Codable, Equatable, Identifiable {
    let id: Int?
    let createdDate: String?
    let lastModifiedDate: String?
    let paymentMethod: String?
    let status: String?
    let paidAt: String?
}

