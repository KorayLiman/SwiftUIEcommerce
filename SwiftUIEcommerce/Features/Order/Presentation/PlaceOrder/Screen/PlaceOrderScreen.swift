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
                            viewModel.showAddAddressSheet.toggle()
                        }
                        Spacer()
                    }
                    .sheet(isPresented: $viewModel.showAddAddressSheet) {
                        AddressSheetView()
                            .presentationDetents([.medium, .large])
                    }
               
                } header: {
                    ECText(localizedStringKey: "L.Address")
                        .ecTextColor(.ecOnBackgroundVariant1)
                }
                
                Section {
                    Picker(selection: $viewModel.selectedPaymentMethod) {
                        ForEach(viewModel.paymentMethods, id: \.self) { (method: String) in
                            ECText(localizedStringKey: "\(method)").tag(method)
                        }
                    } label: {
                        ECText(localizedStringKey: "L.ChoosePaymentMethod")
                    }
                
                } header: {
                    ECText(localizedStringKey: "L.PaymentMethod")
                        .ecTextColor(.ecOnBackgroundVariant1)
                }
                
                Section {
                    TextField("L.PaymentNotePlaceholder", text: $viewModel.orderNote, axis: .vertical)
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
        .environment(viewModel)
    }
}

private struct PlaceOrderButton: View {
    @Environment(PlaceOrderViewModel.self) private var viewModel
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                ECFilledButton(localizedStringKey: "L.CompleteOrder") {
                    Task {
                        await viewModel.placeOrder()
                    }
                }
                .ecMaxWidth(.infinity)
                .ecDisabled(viewModel.selectedAddress == nil || viewModel.selectedPaymentMethod.isEmpty)
            }
        }
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity, maxHeight: 80)
        .background(.ecBackgroundVariant2)
    }
}

private struct AddressSheetView: View {
    @State private var name: String = ""
    @State private var city: String = ""
    @State private var district: String = ""
    @State private var addressDescription: String = ""
    
    @Environment(PlaceOrderViewModel.self) private var viewModel
    
    var body: some View {
        Form {
            Section {
                ECTextField(placeholder: "L.Name", text: $name)
                    .ecBackgroundColor(.clear)
                ECTextField(placeholder: "L.City", text: $city)
                    .ecBackgroundColor(.clear)
                ECTextField(placeholder: "L.District", text: $district)
                    .ecBackgroundColor(.clear)
                ECTextField(placeholder: "L.AddressDescription", text: $addressDescription)
                    .ecBackgroundColor(.clear)
                    .lineLimit(4, reservesSpace: true)
                ECFilledButton(localizedStringKey: "L.AddAddress") {
                    let addressRequestModel = AddAddressRequestModel(name: name, city: city, district: district, addressDescription: addressDescription)
                    Task {
                        await viewModel.addNewAddress(address: addressRequestModel)
                    }
                }
                .ecMaxWidth(.infinity)
                .disabled(name.isEmpty || city.isEmpty || district.isEmpty || addressDescription.isEmpty)
            }
            header: {
                HStack {
                    ECText(localizedStringKey: "L.AddNewAddress")
                        .ecTextColor(.ecOnBackgroundVariant1)
                    Spacer()
                    ECIconButton(iconName: "xmark") {
                        viewModel.showAddAddressSheet = false
                    }
                    .ecSize(14)
                }
            }
        }
    }
}

#Preview("Add New Address Sheet") {
    AddressSheetView()
        .environment(PlaceOrderViewModel())
}

#Preview {
    PlaceOrderScreen()
}
