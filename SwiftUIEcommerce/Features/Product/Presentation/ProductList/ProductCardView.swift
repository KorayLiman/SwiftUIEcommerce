//
//  ProductCardView.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI

struct ProductCardView: View {
    let product: ProductResponseModel
    
    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 16) {
                if let id = product.id {
                    ECAsyncImage(id: id)
                        .frame(width: proxy.size.width * 0.35)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    ECText(label: product.name ?? "")
                        
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.ecOnBackground)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 3)
        }
    }
}
