//
//  ProductListScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI

struct ProductListScreen: View {
    @State private var selectedCategory: CategoryResponseModel = .all()
    var body: some View {
        VStack(spacing: 16) {
            CategoriesHStackView(selectedCategory: $selectedCategory)
            ProductsListView(selectedCategory: $selectedCategory)
        }
        .background(.ecBackgroundVariant)
    }
}

private struct CategoriesHStackView: View {
    @State private var categories: [CategoryResponseModel] = []
    @Binding var selectedCategory: CategoryResponseModel
    @Environment(ProductStore.self) private var productStore

    var body: some View {
        ECScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(categories, id: \.self) { (category: CategoryResponseModel) in
                    ECText(label: category.name ?? "", foregroundColor: selectedCategory == category ? .ecOnAccent : .ecOnBackground)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(selectedCategory == category ? .ecAccent : .ecBackgroundVariant2)
                        .cornerRadius(20)
                        .onTapGesture {
                            selectedCategory = category
                        }
                }
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: 40)
        .task {
            categories = await productStore.getProductCategories()
        }
    }
}

private struct ProductsListView: View {
    @State private var products: [ProductResponseModel] = []

    @Binding var selectedCategory: CategoryResponseModel
    @Environment(ProductStore.self) private var productStore

    var body: some View {
        ECScrollView {
            LazyVStack {
                ForEach(products, id: \.self) { (product: ProductResponseModel) in
                    ProductCardView(product: product)
                        .frame(maxWidth: .infinity)
                        .aspectRatio(2.5, contentMode: .fill)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 24)
                }
            }

        }.task {
            let products = await productStore.getAllProducts()
            guard selectedCategory == .all() else { return }
            self.products = products
        }
        .onChange(of: selectedCategory) { oldValue, newValue in
            guard newValue != oldValue else { return }
            Task {
                products = await getProductsByCategory(category: newValue)
            }
        }
    }
}

private extension ProductsListView {
    func getProductsByCategory(category: CategoryResponseModel) async -> [ProductResponseModel] {
        if category == .all() {
            return await productStore.getAllProducts()
        } else {
            if let id = category.id {
                return await productStore.getProductsByCategoryId(id)
            }
            return []
        }
    }
}

#Preview {
    ProductListScreen()
}
