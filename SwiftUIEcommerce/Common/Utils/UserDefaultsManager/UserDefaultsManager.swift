//
//  UserDefaultsManager.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 18.07.2025.
//

import SwiftUI

final class UserDefaultsManager {
    private var userDefaults: UserDefaults = .standard

    func setObject<T: Codable>(_ value: T, forKey key: UserDefaultsKeys) throws {
        let data = try JSONEncoder().encode(value)
        userDefaults.set(data, forKey: key.rawValue)
    }

    func getObject<T: Codable>(_ type: T.Type ,forKey key: UserDefaultsKeys) throws -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            return nil
        }

        let value = try JSONDecoder().decode(T.self, from: data)
        return value
    }

    func removeObject(forKey key: UserDefaultsKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}

enum UserDefaultsManagerKey: EnvironmentKey {
    static var defaultValue = UserDefaultsManager()
}

extension EnvironmentValues {
    var userDefaultsManager: UserDefaultsManager {
        get { self[UserDefaultsManagerKey.self] }
        set { self[UserDefaultsManagerKey.self] = newValue }
    }
}
