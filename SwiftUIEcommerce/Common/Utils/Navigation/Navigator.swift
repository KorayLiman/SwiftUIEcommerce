//
//  NavigationType.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 13.07.2025.
//

import SwiftUI

@Observable
final class Navigator {
    var path = [Route]()
    var cartPath = [CartRoute]()

    func push(_ route: Route) {
        path.append(route)
    }

    func push(_ route: CartRoute) {
        cartPath.append(route)
    }

    func replaceCurrent(_ route: Route) {
        guard !path.isEmpty else { return }
        path[path.count - 1] = route
    }

    func replaceCurrent(_ route: CartRoute) {
        guard !cartPath.isEmpty else { return }
        cartPath[cartPath.count - 1] = route
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popCart() {
        guard !cartPath.isEmpty else { return }
        cartPath.removeLast()
    }

    func popUntil(_ route: Route) {
        guard let index = path.firstIndex(where: { $0 == route }) else { return }
        path = Array(path.prefix(upTo: index + 1))
    }

    func popUntil(_ route: CartRoute) {
        guard let index = cartPath.firstIndex(where: { $0 == route }) else { return }
        cartPath = Array(cartPath.prefix(upTo: index + 1))
    }

    func popToRoot() {
        path.removeAll()
    }

    func popCartToRoot() {
        cartPath.removeAll()
    }
}
