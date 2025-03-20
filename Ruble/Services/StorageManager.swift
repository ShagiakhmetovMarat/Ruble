//
//  StorageManager.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 18.03.2025.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let currencyKey = "currency"
    
    private init() {}
    
    func saveData(currency: [Currency]) {
        guard let data = try? JSONEncoder().encode(currency) else { return }
        userDefaults.set(data, forKey: currencyKey)
    }
    
    func fetchData() -> [Currency] {
        guard let data = userDefaults.data(forKey: currencyKey) else { return [] }
        guard let currency = try? JSONDecoder().decode([Currency].self, from: data) else { return [] }
        return currency
    }
}
