//
//  GroupsViewModel.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 28/09/25.
//

import SwiftUI
import Combine

final class GroupsViewModel: ObservableObject {
    
    @Published var groups: [GroupDisplayItem] = DummyData.groups
    
    func addGroup(_ group: GroupDisplayItem) {
        groups.append(group)
    }
}

enum GroupSettlementStatus: String, Codable {
    case settled
    case pending
    case incoming
    case noExpense
    
    var title: String {
        switch self {
        case .settled: return "Settled"
        case .pending: return "Settle up"
        case .noExpense: return "No Expenses"
        case .incoming: return "Owed to you"
        }
    }
}
