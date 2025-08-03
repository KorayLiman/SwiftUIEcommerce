//
//  AddressResponseModel.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 2.08.2025.
//

struct AddressResponseModel: Codable, Hashable, Identifiable, Equatable {
    let id: Int?
    let createdDate: String?
    let lastModifiedDate: String?
    let name: String?
    let city: String?
    let district: String?
    let addressDescription: String?
    
    
   // moc adress
    static var mock:   AddressResponseModel {
        AddressResponseModel(id: Int.random(in: 1...9999), createdDate: "2025-08-02T12:00:00Z", lastModifiedDate: "2025-08-02T12:00:00Z", name: "John Doe", city: "New York", district: "Manhattan", addressDescription: "123 Main St, Apt 4B")
    }
}
