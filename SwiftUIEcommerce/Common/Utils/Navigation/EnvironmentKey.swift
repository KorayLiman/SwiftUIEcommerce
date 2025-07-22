//
//  EnvironmentKey.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 13.07.2025.
//

import SwiftUI

struct NavigatorEnvironmentKey: EnvironmentKey {
    static var defaultValue: Navigator = .init()
}

extension EnvironmentValues {
    var rootNavigator: Navigator {
        get { self[NavigatorEnvironmentKey.self] }
        set { self[NavigatorEnvironmentKey.self] = newValue }
    }
}
