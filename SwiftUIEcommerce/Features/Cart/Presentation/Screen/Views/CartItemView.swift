//
//  CartItemView.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 2.08.2025.
//

import SwiftUI

struct CartItemView: View {
    @Environment(CartViewModel.self) private var cartViewModel
    @Environment(\.colorScheme) private var colorScheme
    let item: MergedCartItemModel

    var body: some View {
        let product = item.product
        GeometryReader { proxy in
            HStack(spacing: 16) {
                if let id = product.id {
                    ECAsyncImage(id: id)
                        .frame(width: proxy.size.width * 0.35)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    VStack(alignment: .leading, spacing: 4) {
                        HStack(alignment: .top) {
                            ECText(label: product.name ?? "")
                                .ecTextColor(.ecOnBackground)
                                .font(.headline)
                                .lineLimit(2)
                                .truncationMode(.tail)
                            Spacer()
                            ECText(label: String(format: "%.2f ₺", (product.price ?? 0) * Double(item.quantity)))
                                .ecTextColor(.ecBackground)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .padding(8)
                                .background(.ecOnBackgroundVariant)
                                .cornerRadius(12)
                        }
                        ECText(label: product.description ?? "")
                            .ecTextColor(.ecOnBackgroundVariant)
                            .font(.subheadline)
                            .lineLimit(3)
                            .truncationMode(.tail)

                        Spacer()
                        HStack {
                            Spacer()
                            if cartViewModel.getCartItemCount(product: product) == 0 { ECIconButton(iconName: "plus") {
                                Task {
                                    await cartViewModel.addToCart(product: product)
                                }
                            }
                            }
                            else {
                                HStack(spacing: 0) {
                                    let iconName = cartViewModel.getCartItemCount(product: product) == 1 ? "trash" : "minus"
                                    ECIconButtonRaw(iconName: iconName) {
                                        Task {
                                            await cartViewModel.removeFromCart(product: product)
                                        }
                                    }
                                    .ecSize(20)

                                    ECText(label: String(cartViewModel.getCartItemCount(product: product)))
                                        .ecTextColor(.ecOnBackground)
                                        .font(.headline)
                                        .padding(.horizontal, 12)
                                        
                                    ECIconButtonRaw(iconName: "plus") {
                                        Task {
                                            await cartViewModel.addToCart(product: product)
                                        }
                                    }
                                    .ecSize(20)
                                }
                                .padding(8)
                                .background(Capsule().fill(Color.ecBackgroundVariant2))
                            }
                        }
                    }
                    .padding(16)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(colorScheme == .light ? .ecBackground : .ecBackgroundVariant1)
            .cornerRadius(16)
            .shadow(color: .ecOnBackground.opacity(0.3), radius: 2, x: 0, y: 1)
        }
    }
}

#Preview {
    CartItemView(item: MergedCartItemModel(id: 0, product: ProductResponseModel(), quantity: 2))
}
