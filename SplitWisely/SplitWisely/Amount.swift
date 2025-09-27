//
//  Amount.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 27/09/25.
//

import SwiftUI

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
