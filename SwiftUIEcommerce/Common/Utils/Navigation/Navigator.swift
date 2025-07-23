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

    func push(_ route: Route) {
        path.append(route)
    }

    func replaceCurrent(_ route: Route) {
        guard !path.isEmpty else { return }
        path[path.count - 1] = route
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popUntil(_ route: Route) {
        guard let index = path.firstIndex(where: { $0 == route }) else { return }
        path = Array(path.prefix(upTo: index + 1))
    }

    func popToRoot() {
        path.removeAll()
    }
}
