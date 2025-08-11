//
//  ProfileMenuScreen.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 6.08.2025.
//

import SwiftUI

struct ProfileMenuScreen: View {
    @State private var viewModel = ProfileMenuViewModel()

    var body: some View {
        List {
            Section {
                ECText(label: viewModel.user?.user?.name ?? "")
                    .ecTextColor(.ecBackground)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .listRowBackground(Color.ecOnBackground)

            Section {
                NavigationLink(destination: OrdersScreen()

                ) {
                    ECText(localizedStringKey: "L.Orders")
                        .ecTextColor(.ecOnBackground)
                }
                NavigationLink(destination: AddressesScreen()
                   
                ) {
                    ECText(localizedStringKey: "L.Addresses")
                        .ecTextColor(.ecOnBackground)
                }

                NavigationLink(destination: ChangePasswordScreen()
                ) {
                    ECText(localizedStringKey: "L.ChangePassword")
                        .ecTextColor(.ecOnBackground)
                }

                HStack {
                    ECText(localizedStringKey: "L.Version")
                        .ecTextColor(.ecOnBackgroundVariant2)
                    Spacer()
                    ECText(label: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A")
                        .ecTextColor(.ecOnBackgroundVariant2)
                }
            }
            HStack {
                Spacer()
                ECFilledButton(localizedStringKey: "L.Logout") {
                    viewModel.logout()
                }
                Spacer()
            }
            .listRowBackground(Color.clear)
        }
        .scrollContentBackground(.hidden)
        .background(.ecBackgroundVariant)
        .navigationTitle("L.Profile")
        .navigationBarTitleDisplayMode(.inline)
        .taskOnce {
            await viewModel.getCurrentUserInfo()
        }
    }
}

#Preview {
    ProfileMenuScreen()
}
