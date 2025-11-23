//
//  SplitViewModel.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 23/11/25.
//

import Foundation
import Combine

enum ExpenseSplitMode{
    case equal
    case shares
    case percent
    case manual
    
    var title: String{
        switch self{
        case .equal:
            return "Split equally"
        case .shares:
           return "Split by shares"
        case .percent:
           return "Split by percentages"
        case .manual:
           return "Split by exact amounts"
        }
    }
    
    var buttonTitle: String{
        switch self{
        case .equal:
            return "="
        case .shares:
           return "𝌔"
        case .percent:
           return "%"
        case .manual:
           return "1.23"
        }
    }
}

class SplitViewModel: ObservableObject{
    @Published var splitMode: ExpenseSplitMode = .manual
    @Published var participants: [Participant]
    @Published var totalToBeSplit: Amount
    @Published var shares: Int = 0
    
    init(splitMode: ExpenseSplitMode, participants: [Participant], totalToBeSplit: Amount) {
        self.splitMode = splitMode
        self.participants = participants
        self.totalToBeSplit = totalToBeSplit
    }
    
    func reCalculate(with: Participant) {
        switch splitMode {
        case .equal:
            var selectedCount = 0
            for participant in participants {
                if participant.amountOwed > 0 {
                    selectedCount += 1
                }
            }
            let equalShare = totalToBeSplit.value / Decimal(selectedCount)
        case .shares:
            for participant in participants {
                if participant.amountOwed > 0 {
                    shares += 1
                }
            }
            let pricePerShare = totalToBeSplit.value / Decimal(shares)
        case .percent:
            var selectedCount = 0
            for participant in participants {
                if participant.amountOwed > 0 {
                    selectedCount += 1
                }
            }
            let equalShare = totalToBeSplit.value / Decimal(selectedCount)

        case .manual:
            var selectedCount = 0
            for participant in participants {
                if participant.amountOwed > 0 {
                    selectedCount += 1
                }
            }
            let equalShare = totalToBeSplit.value / Decimal(selectedCount)

        }
    }
}
