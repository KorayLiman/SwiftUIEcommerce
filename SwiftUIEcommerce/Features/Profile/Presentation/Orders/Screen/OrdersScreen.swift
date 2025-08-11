//
//  OrdersScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 7.08.2025.
//

import SwiftUI

struct OrdersScreen: View {
    @State private var viewModel = OrdersViewModel()
    var body: some View {
        ECScrollView {
            LazyVStack {
                ForEach(viewModel.orders, id: \.self.id) { (order: OrderResponseModel) in
                    OrderCardView(order: order)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 16)
                }
            }
            
        }
        .navigationTitle("L.Orders")
        .navigationBarTitleDisplayMode(.inline)
        .environment(viewModel)
        .taskOnce {
            await viewModel.getOrders()
        }
    }
}

#Preview {
    OrdersScreen()
}
