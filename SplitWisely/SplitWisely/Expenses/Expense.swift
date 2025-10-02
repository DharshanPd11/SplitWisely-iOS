//
//  Expense.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 03/10/25.
//

import SwiftUI


struct Participant: Identifiable, Codable {
    let id: UUID
    let name: String
    var amountOwed: Double
}

struct Expense: Identifiable {
    let id: UUID
    
    var title: String
    var totalAmount: Amount
    var date: Date?
    var paidBy: Participant
    var participants: [Participant]
    
    var type: ExpenseType
    
    var note: String?
    var receipt: Image?
    var addedDate: Date

    // Computed properties for UI
    var amountForCurrentUser: Double {
        // For example, assuming current user is one of the participants
        participants.first(where: { $0.id == currentUserID })?.amountOwed ?? 0
    }
    
    // Current user ID can come from your auth/session manager
    var currentUserID: UUID = UUID()
}
