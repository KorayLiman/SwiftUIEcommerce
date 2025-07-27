//
//  UserDefaultsManager.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 18.07.2025.
//

import SwiftUI


protocol IUserDefaultsManager {
    func setObject<T: Codable>(_ value: T, forKey key: UserDefaultsKeys) -> Bool
    func getObject<T: Codable>(_ type: T.Type, forKey key: UserDefaultsKeys) -> T?
    func removeObject(forKey key: UserDefaultsKeys)
}


final class UserDefaultsManager: IUserDefaultsManager {
    private var userDefaults: UserDefaults = .standard

    func setObject<T: Codable>(_ value: T, forKey key: UserDefaultsKeys) -> Bool {
        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key.rawValue)
            return true
        } catch {
            return false
        }
    }

    func getObject<T: Codable>(_ type: T.Type, forKey key: UserDefaultsKeys) -> T? {
        guard let data = userDefaults.data(forKey: key.rawValue) else {
            return nil
        }

        do {
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch {
            return nil
        }
    }

    func removeObject(forKey key: UserDefaultsKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
