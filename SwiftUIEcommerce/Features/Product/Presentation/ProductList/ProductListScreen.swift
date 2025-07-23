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
    }
}

private struct CategoriesHStackView: View {
    @State private var categories: [CategoryResponseModel] = []
    @Binding var selectedCategory: CategoryResponseModel
    @Environment(ProductStore.self) private var productStore

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 12) {
                ForEach(categories, id: \.self) { (category: CategoryResponseModel) in
                    Text(category.name ?? "")
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(selectedCategory == category ? .accent : .secondary.opacity(0.2))
                        .foregroundColor(selectedCategory == category ? .onAccent : .primary)
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
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(products, id: \.self) { (product: ProductResponseModel) in
                    Text(product.name ?? "")
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
