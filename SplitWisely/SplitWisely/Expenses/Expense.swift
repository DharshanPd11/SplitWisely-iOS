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
    // Current user ID can come from your auth/session manager
    var currentUserID: UUID = UUID()

    let id: UUID    
    var group: GroupDisplayItem
    var name: String
    var amount: Decimal
    var currency: Currency
    var date: Date?
    var paidBy: ParticipantCardView.DisplayItem
    var splitMode: PaymentSplitMode
    var participants: [ParticipantCardView.DisplayItem]
//    var type: ExpenseInvolvementType
    var notes: String = ""
    var receiptImage: UIImage?
    var addedDate: Date
    var expenseDate: Date?
    
    // Computed properties for UI
//    var amountForCurrentUser: Double {
//        participants.first(where: { $0.id == currentUserID })?.amountOwed ?? 0
//    }
    
}
