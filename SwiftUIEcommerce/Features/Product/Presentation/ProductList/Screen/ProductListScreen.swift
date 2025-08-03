//
//  ProductListScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI

struct ProductListScreen: View {
    @State private var viewModel = ProductListViewModel()

    var body: some View {
        VStack(spacing: 16) {
            CategoriesHStackView()
            ProductsListView()
        }
        .navigationTitle("L.Products")
        .navigationBarTitleDisplayMode(.inline)
        .background(.ecBackgroundVariant)
        .environment(viewModel)
    }
}

private struct CategoriesHStackView: View {
    @Environment(ProductListViewModel.self) private var viewModel

    var body: some View {
        ECScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(viewModel.categories, id: \.self) { (category: CategoryResponseModel) in
                    ECText(label: category.name ?? "")
                        .ecTextColor(viewModel.selectedCategory == category ? .ecOnAccent : .ecOnBackground)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(viewModel.selectedCategory == category ? .ecAccent : .ecBackgroundVariant2)
                        .cornerRadius(20)
                        .onTapGesture {
                            viewModel.selectedCategory = category
                        }
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .taskOnce {
            await viewModel.getProductCategories()
        }
    }
}

private struct ProductsListView: View {
    @Environment(ProductListViewModel.self) private var viewModel

    var body: some View {
        ECScrollView {
            LazyVStack {
                ForEach(viewModel.products, id: \.self) { (product: ProductResponseModel) in
                    ProductCardView(product: product)
                        .frame(maxWidth: .infinity)
                        .aspectRatio(2.5, contentMode: .fill)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 24)
                }
            }

        }.taskOnce {
            async let products: () = viewModel.getAllProducts()
            async let cartItems: () = viewModel.getCartItems()
            _ = await (products, cartItems)
        }
        .onChange(of: viewModel.selectedCategory) { oldValue, newValue in
            guard newValue != oldValue else { return }
            Task {
                await viewModel.getProductsByCategory(category: newValue)
            }
        }
    }
}

#Preview {
    ProductListScreen()
}
