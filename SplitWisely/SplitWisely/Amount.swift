//
//  Amount.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 27/09/25.
//

import SwiftUI
import FoundationModels

struct Amount {
    var value: Decimal
    var currencyCode: String
    
    var isPositive: Bool {
        value > 0
    }
    
    var color: Color {
        value < 0 ? .green : .red
    }
    
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.maximumFractionDigits = 2
        return formatter.string(from: value as NSDecimalNumber) ?? "\(value)"
    }
}

struct Currency: Codable, Identifiable {
    var id: UUID?
    let symbol, name, symbol_native: String
    let decimal_digits, rounding: Decimal
    let code, name_plural: String
}

struct AllCurrencies {

    var currentCurrency: Currency = Currency(symbol: "Rs", name: "Indian Rupee", symbol_native: "টকা", decimal_digits: 2, rounding: 0, code: "INR", name_plural: "Indian Rupees")
    
    func load() -> [Currency]? {
        guard let url = Bundle.main.url(forResource: "currencies", withExtension: "json") else {
            print("❌ currencies.json not found in bundle")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            var list = try JSONDecoder().decode([Currency].self, from: data)
            for ind in 0..<list.count{
                list[ind].id = UUID()
            }
            return list
        } catch {
            print("❌ Error decoding JSON:", error)
            return nil
        }
    }
}

