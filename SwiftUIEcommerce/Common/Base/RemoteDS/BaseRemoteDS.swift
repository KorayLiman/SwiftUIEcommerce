//
//  BaseRemoteDS.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 27.07.2025.
//

class BaseRemoteDS {
    let networkManager: NetworkManager

    init() {
        self.networkManager = DIContainer.shared.container.resolve(NetworkManager.self)!
    }
}
