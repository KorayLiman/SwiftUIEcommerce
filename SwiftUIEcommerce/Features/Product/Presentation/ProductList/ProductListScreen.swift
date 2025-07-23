//
//  ProductListScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI

struct ProductListScreen: View {
    @State private var selectedCategory: CategoryResponseModel? = nil
    var body: some View {
        VStack {
            CategoriesHStackView(selectedCategory: $selectedCategory)
        }
    }
}

private struct CategoriesHStackView: View {
    @State private var categories: [CategoryResponseModel] = []
    @Binding var selectedCategory: CategoryResponseModel?
    @Environment(\.networkManager) private var networkManager
    @Environment(ToastManager.self) private var toastManager

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
                     LazyHStack(spacing: 12) {
                         ForEach(categories, id: \.self) { (category: CategoryResponseModel) in
                             Text(category.name ?? "")
                                 .padding(.vertical, 8)
                                 .padding(.horizontal, 16)
                                 .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                 .foregroundColor(selectedCategory == category ? .white : .primary)
                                 .cornerRadius(20)
                                 .onTapGesture {
                                     selectedCategory = category
                                 }
                         }
                     }
                     .padding(.horizontal)
                 }
            .task {
                let response = await networkManager.request([CategoryResponseModel].self, path: .category, method: .get).showMessage(toastManager)
                if let data = response.data {
                    categories = data
                }
            }
    }
}

#Preview {
    ProductListScreen()
}
