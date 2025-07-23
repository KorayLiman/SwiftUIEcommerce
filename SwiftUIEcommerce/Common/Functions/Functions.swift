//
//  Functions.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

func withLoader<T>(loader: ECLoader, _ operation: @escaping () async throws -> T) async rethrows -> T {
    loader.show()
    defer { loader.hide() }
    return try await operation()
}
