//
//  EncodableExtensions.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 16.07.2025.
//

import SwiftUI

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
        return jsonObj as? [String: Any] ?? [:]
    }
}
