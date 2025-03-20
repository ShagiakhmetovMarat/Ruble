//
//  Exchange.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 20.03.2025.
//

import Foundation

struct Exchange: Decodable {
    let Valute: [String: DataCurrency]
}

struct DataCurrency: Decodable {
    let CharCode: String
    let Nominal: Int
    let Name: String
    let Value: Double
    let Previous: Double
}

enum URLS: String {
    case currencyAPI = "https://www.cbr-xml-daily.ru/daily_json.js"
}
