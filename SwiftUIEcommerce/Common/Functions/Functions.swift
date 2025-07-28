//
//  Functions.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

func withLoader<T>( _ operation: @escaping () async throws -> T) async rethrows -> T {
    let loader = DIContainer.shared.synchronizedResolver.resolve(ECLoader.self)
    loader?.show()
    defer { loader?.hide() }
    return try await operation()
}
