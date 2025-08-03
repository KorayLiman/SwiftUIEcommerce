//
//  PlaceOrderScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 2.08.2025.
//

import SwiftUI

struct PlaceOrderScreen: View {
    @State private var viewModel = PlaceOrderViewModel()
    var body: some View {
        VStack {
            List {
                Section {
                    Picker(selection: $viewModel.selectedAddress) {
                        ForEach(viewModel.addresses, id: \.self) { (address: AddressResponseModel) in
                            Text(address.name ?? "").tag(address)
                        }
                    } label: {
                        ECText(localizedStringKey: "L.SelectAddress")
                    }
                    .pickerStyle(.navigationLink)
                    HStack {
                        Spacer()
                        ECTextButton(localizedStringKey: "L.AddNewAddress") {
                            // Action
                        }
                        Spacer()
                    }
                   
                } header: {
                    ECText(localizedStringKey: "L.Address")
                        .ecTextColor(.ecOnBackgroundVariant1)
                }
                
                Section {
                    Picker(selection: $viewModel.selectedAddress) {
                        ForEach(viewModel.addresses, id: \.self) { (address: AddressResponseModel) in
                            Text(address.name ?? "").tag(address)
                        }
                    } label: {
                        ECText(localizedStringKey: "L.Address")
                    }
                
                   
                } header: {
                    ECText(localizedStringKey: "L.PaymentMethod")
                        .ecTextColor(.ecOnBackgroundVariant1)
                }
                
                Section {
                    TextField("L.PaymentNotePlaceholder", text: .constant(""), axis: .vertical)
                        .lineLimit(4, reservesSpace: true)
                        
                } header: {
                    ECText(localizedStringKey: "L.PaymentNote")
                        .ecTextColor(.ecOnBackgroundVariant1)
                }
            }
            
            Spacer()
            PlaceOrderButton()
        }
       
        .scrollContentBackground(.hidden)
        .background(.ecBackgroundVariant1)
        .navigationTitle("L.PlaceOrder")
        .taskOnce {
            await viewModel.getAddressList()
        }
    }
}

private struct PlaceOrderButton: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                ECFilledButton(localizedStringKey: "L.CompleteOrder") {}
                    .ecMaxWidth(.infinity)
            }
        }
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity, maxHeight: 80)
        .background(.ecBackgroundVariant2)
    }
}

#Preview {
    PlaceOrderScreen()
}
