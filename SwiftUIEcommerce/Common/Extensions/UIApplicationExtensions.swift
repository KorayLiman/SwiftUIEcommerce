//
//  UIApplicationExtensions.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 21.07.2025.
//

import UIKit

extension UIApplication {
    func endEditing(_ force: Bool = false) {
        if let windowScene = connectedScenes.first as? UIWindowScene {
            windowScene.windows.first { $0.isKeyWindow }?.endEditing(true)
        }
    }
}
