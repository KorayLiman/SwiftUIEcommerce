//
//  OrderCardView.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 7.08.2025.
//

import OrderedCollections
import SwiftUI

struct OrderCardView: View {
    let order: OrderResponseModel
    @State private var isCancelAlertPresented: Bool = false
    @State private var isOrderDetailsPresented: Bool = false
    @Environment(OrdersViewModel.self) private var ordersViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                ECText(localizedStringKey: "L.OrderNumber")
                    .ecTextColor(.ecOnBackground)
                    .fontWeight(.semibold)
                Spacer()
                ECText(label: "\(String(format: "%.2f", order.totalAmount ?? 0)) ₺")
                    .ecTextColor(.ecOnBackground)
                    .fontWeight(.semibold)
            }
            ECText(label: "\(order.id ?? 0)")
                .ecTextColor(.ecOnBackgroundVariant)

            HStack(alignment: .top) {
                ECText(localizedStringKey: "L.OrderDate")
                    .ecTextColor(.ecOnBackground)
                    .fontWeight(.semibold)
                Spacer()
                Image(systemName: "chevron.right.circle")
                    .foregroundStyle(.ecAccent)
            }
            ECText(label: order.createdDate ?? "")
                .ecTextColor(.ecOnBackgroundVariant)

            HStack(alignment: .center) {
                ECText(label: order.status ?? "")
                    .ecTextColor(.ecAccent)
                    .fontWeight(.semibold)
                Spacer()
                if order.status == "PENDING" || order.status == "PREPARING" {
                    ECFilledButton(localizedStringKey: "L.Cancel") {
                        isCancelAlertPresented = true
                    }
                    .clipShape(.capsule)
                    .alert(isPresented: $isCancelAlertPresented) {
                        Alert(
                            title: Text("L.CancelOrder"),
                            message: Text("L.AreYouSureToCancelOrder"),
                            primaryButton: .destructive(Text("L.Yes")) {
                                Task {
                                    await ordersViewModel.cancelOrder(orderId: order.id ?? 0)
                                }
                            },
                            secondaryButton: .cancel(Text("L.No"))
                        )
                    }
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16)
            .fill(.ecBackground))
        .shadow(color: .ecOnBackground.opacity(0.3), radius: 2, x: 0, y: 1)
        .onTapGesture {
            isOrderDetailsPresented = true
        }
        .sheet(isPresented: $isOrderDetailsPresented) {
            OrderDetailsSheetView(order: order)
                .presentationDragIndicator(.visible)
        }
    }
}

private struct OrderDetailsSheetView: View {
    let order: OrderResponseModel
    
    @Environment(\.presentationMode) private var presentationMode
    
    var mergedCartItems: [MergedCartItemModel] {
        let grouped = OrderedDictionary(grouping: order.cartItems ?? [], by: { $0.product?.id ?? -1 })

        return grouped.compactMap { key, items in
            guard let product = items.first?.product, key != -1 else { return nil }

            return MergedCartItemModel(
                id: key,
                product: product,
                quantity: items.count
            )
        }
    }
    
    var body: some View {
        NavigationStack {
            ECScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        ECText(localizedStringKey: "L.OrderNumber")
                            .ecTextColor(.ecOnBackground)
                          
                        Spacer()
                        ECText(label: order.status ?? "")
                            .ecTextColor(.ecAccent)
                    }
                
                    
                    ECText(label: "\(order.id ?? 0)")
                        .ecTextColor(.ecOnBackgroundVariant)
                        .padding(.bottom, 4)
                    
                    ECText(localizedStringKey: "L.OrderDate")
                        .ecTextColor(.ecOnBackground)
                    
                    ECText(label: order.createdDate ?? "")
                        .ecTextColor(.ecOnBackgroundVariant)
                        .padding(.bottom, 4)
                    
                    ECText(localizedStringKey: "L.Address")
                        .ecTextColor(.ecOnBackground)
                   
                    if let address = order.address {
                        ECText(label: "\(address.name ?? "")\n\(address.addressDescription ?? "")\n\(address.district ?? "") / \(address.city ?? "")")
                            .ecTextColor(.ecOnBackgroundVariant)
                            .padding(.bottom, 4)
                    }
                    
                    ECText(localizedStringKey: "L.PaymentNote")
                        .ecTextColor(.ecOnBackground)
                        .padding(.bottom, 4)
                        
                    
                    DottedLine()
               
                    ForEach(mergedCartItems, id: \.id) { (item: MergedCartItemModel) in
                            
                        CartItemView(item: item)
                            .frame(maxWidth: .infinity, maxHeight: 80)
                            .padding(.vertical, 8)
                    }
                    
                    DottedLine()
                        .padding(.bottom, 4)
                    HStack {
                        ECText(localizedStringKey: "L.TotalAmount")
                            .ecTextColor(.ecOnBackground)
                          
                        Spacer()
                        
                        ECText(label: String(format: "%.2f ₺", order.totalAmount ?? 0))
                            .ecTextColor(.ecOnBackground)
                           
                    }
                }
                .padding()
            }
            .toolbar(content: {
                ToolbarItem {
                    ECIconButton(iconName: "xmark") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .ecSize(14)
                }
            })
            .navigationTitle("L.OrderDetails")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    @ViewBuilder
    func CartItemView(item: MergedCartItemModel) -> some View {
        HStack {
            ECAsyncImage(id: item.product.imageFile?.id ?? 0)
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 16))
            
            ECText(label: item.product.name ?? "")
                .ecTextColor(.ecOnBackground)
                .font(.headline)
                .lineLimit(2)
                .truncationMode(.tail)
            
            Spacer()
            ECText(label: String(format: "%.2f ₺", Double(item.quantity) * (item.product.price ?? 0)))
                .ecTextColor(.ecOnBackground)
                .font(.footnote)
                .fontWeight(.semibold)
        }
    }
}

private struct DottedLine: View {
    var body: some View {
        Path { path in
            path.move(to: .zero)
            path.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        }
        .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
        .foregroundColor(.ecOnBackgroundVariant1)
        .frame(height: 1)
    }
}

#Preview {
    DottedLine()
}
