//
//  Currency.swift
//  Ruble
//
//  Created by Marat Shagiakhmetov on 17.03.2025.
//

import Foundation

struct Currency: Codable {
    let flag: String
    let charCode: String
    let name: String
    var isOn: Bool
    var value: CGFloat
}
