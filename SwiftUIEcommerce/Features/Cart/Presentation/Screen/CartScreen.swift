//
//  CartScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 2.08.2025.
//

import SwiftUI

struct CartScreen: View {
    @State private var viewModel = CartViewModel()

    var body: some View {
        VStack {
            CartItemsView()

            Spacer()
            TotalCountBottomView()
        }
        .navigationTitle("L.Cart")
        .navigationBarTitleDisplayMode(.inline)
        .background(.ecBackgroundVariant)
        .environment(viewModel)
        .taskOnce {
            await viewModel.getCartItems()
        }
    }
}

struct CartItemsView: View {
    @Environment(CartViewModel.self) private var viewModel: CartViewModel
    var body: some View {
        ECScrollView {
            LazyVStack {
                ForEach(viewModel.mergedCartItems, id: \.id) { item in
                    CartItemView(item: item)
                        .frame(maxWidth: .infinity)
                        .aspectRatio(2.5, contentMode: .fill)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 24)
                }
            }
            .padding(.top, 16)
        }
    }
}

#Preview {
    CartItemsView()
}

private struct TotalCountBottomView: View {
    @Environment(CartViewModel.self) private var viewModel: CartViewModel
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                let totalPrice = viewModel.mergedCartItems.reduce(0) { $0 + ($1.product.price! * Double($1.quantity)) }
                ECText(localizedStringKey: "L.TotalPrice", foregroundColor: .ecOnBackgroundVariant2, font: .subheadline)
                    .fontWeight(.semibold)
                ECText(label: "\(String(format: "%.2f", totalPrice)) TL", foregroundColor: .ecAccent, font: .title2)
                    .fontWeight(.semibold)
            }
            Spacer()

            ECFilledButton(localizedStringKey: "L.Continue", disabled: viewModel.mergedCartItems.isEmpty) {
                viewModel.goToPlaceOrderPage()
            }
        }
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: 80)
        .background(.ecBackgroundVariant2)
    }
}

#Preview {
    TotalCountBottomView()
}

#Preview {
    CartScreen()
}
