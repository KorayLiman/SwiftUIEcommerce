//
//  ProductCardView.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI

struct ProductCardView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(ProductListViewModel.self) var productListViewModel
    let product: ProductResponseModel

    var body: some View {
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
                            ECText(label: String(format: "%.2f ₺", product.price ?? 0))
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
                            if productListViewModel.getCartItemCount(product: product) == 0 { ECIconButton(iconName: "plus") {
                                Task {
                                    await productListViewModel.addToCart(product: product)
                                }
                            }
                            }
                            else {
                                PlusMinusBotton(product: product)
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

private struct PlusMinusBotton: View {
    @Environment(ProductListViewModel.self) var productListViewModel
    var product: ProductResponseModel
    var body: some View {
        HStack(spacing: 0) {
            let iconName = productListViewModel.getCartItemCount(product: product) == 1 ? "trash" : "minus"
            ECIconButtonRaw(iconName: iconName) {
                Task{
                    await productListViewModel.removeFromCart(product: product)
                }
            }
            .ecSize(16)
            ECText(label: String(productListViewModel.getCartItemCount(product: product)))
                .ecTextColor(.ecOnBackground)
                .font(.headline)
                .padding(.horizontal, 12)
            ECIconButtonRaw(iconName: "plus") {
                Task{
                    await productListViewModel.addToCart(product: product)
                }
            }
            .ecSize(16)
        }
        .padding(8)
        .background(Capsule().fill(Color.ecBackgroundVariant2))
    }
}

#Preview {
    PlusMinusBotton(product: ProductResponseModel(id: 1, createdDate: "2025-07-23", lastModifiedDate: "2025-07-23", name: "Sample Product", description: "This is a sample product description.", price: 99.99, imageFile: nil, category: nil))
}
