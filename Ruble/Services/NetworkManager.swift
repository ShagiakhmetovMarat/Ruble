//
//  NetworkManager.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 20.03.2025.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData(from url: String, with completion: @escaping (Exchange, [DataCurrency]) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let dataExchange = try JSONDecoder().decode(Exchange.self, from: data)
                let exchange = dataExchange.Valute.map { $0.value }
                completion(dataExchange, exchange)
            } catch let error {
                print("Error receiving data: \(error)")
            }
        }.resume()
    }
}
