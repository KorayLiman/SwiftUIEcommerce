//
//  AddressesScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 8.08.2025.
//

import SwiftUI

struct AddressesScreen: View {
    @State private var viewModel = AddressesViewModel()
    @State private var addressToDelete: AddressResponseModel?
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach(viewModel.addresses, id: \.id) { (address: AddressResponseModel) in

                        AddressCardView(address: address)
                            .shadow(color: .ecOnBackground.opacity(0.3), radius: 2, x: 0, y: 1)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    addressToDelete = address
                                }
                                label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                            .listRowBackground(Color.ecBackground)
                           
                    }
                } header: {
                    ECText(localizedStringKey: "L.Addresses")
                        .ecTextColor(.ecOnBackgroundVariant1)
                        .font(.headline)
                    
                }

            }
            
            .scrollContentBackground(.hidden)
                .listStyle(.inset)
                .alert("L.DeleteAddressConfirmation", isPresented: Binding(
                    get: { addressToDelete != nil },
                    set: { if !$0 { addressToDelete = nil } }
                )) {
                    Button("L.Cancel", role: .cancel) {}
                    Button("L.Delete", role: .destructive) {
                        if let id = addressToDelete?.id {
                            Task {
                                await viewModel.deleteAddress(id: id)
                            }
                        }
                    }
                } message: {
                    Text("L.AreYouSureToDeleteAddress")
                }

            ECFilledButton(localizedStringKey: "L.AddNewAddress") {
                viewModel.showAddAddressSheet = true
            }
            .ecMaxWidth(.infinity)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .sheet(isPresented: $viewModel.showAddAddressSheet) {
                AddressSheetView()
                    .presentationDetents([.medium, .large])
            }
        }
        .background(.ecBackgroundVariant)
        .navigationTitle("Addresses")
        .navigationBarTitleDisplayMode(.inline)
        .taskOnce {
            await viewModel.getAddressList()
        }
        .environment(viewModel)
    }
}

private struct AddressCardView: View {
    let address: AddressResponseModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ECText(label: address.name ?? "")
                .ecTextColor(.ecOnBackground)
                .font(.headline)
            ECText(label: "\(address.city ?? ""), \(address.district ?? "")")
                .ecTextColor(.ecOnBackgroundVariant)
            ECText(label: address.addressDescription ?? "")
                .ecTextColor(.ecOnBackgroundVariant2)
                .lineLimit(3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct AddressSheetView: View {
    @State private var name: String = ""
    @State private var city: String = ""
    @State private var district: String = ""
    @State private var addressDescription: String = ""

    @Environment(AddressesViewModel.self) private var viewModel

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

#Preview {
    AddressesScreen()
}
