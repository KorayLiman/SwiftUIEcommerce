//
//  StringExtensions.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 21.07.2025.
//

extension String {
    var isValidEmail: Bool {
        let pattern = #"^\S+@\S+\.\S+$"#
        return self.range(of: pattern, options: .regularExpression) != nil
    }
}
