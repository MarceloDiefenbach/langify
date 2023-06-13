//
//  UserSettings.swift
//  LocalizedStringGenerator
//
//  Created by Marcelo Diefenbach on 28/04/23.
//

import Foundation

class UserDefaultsService {
    
    // MARK: - Singleton
    
    static let shared = UserDefaultsService()
    private init() {}
    
    // MARK: - Properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Save Functions
    
    func saveString(_ value: String, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func saveBool(_ value: Bool, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func saveInt(_ value: Int, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func saveDouble(_ value: Double, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    // MARK: - Fetch Functions
    
    func fetchString(forKey key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    func fetchBool(forKey key: String) -> Bool? {
        return userDefaults.bool(forKey: key)
    }
    
    func fetchInt(forKey key: String) -> Int? {
        return userDefaults.integer(forKey: key)
    }
    
    func fetchDouble(forKey key: String) -> Double? {
        return userDefaults.double(forKey: key)
    }
    
    // MARK: - Remove Function
    
    func remove(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
    
    // MARK: - Clear Function
    
    func clearAll() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            userDefaults.removePersistentDomain(forName: bundleIdentifier)
        }
    }
}

