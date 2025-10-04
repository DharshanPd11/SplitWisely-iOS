//
//  ExpenseViewModel.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 03/10/25.
//

import SwiftUI
import Combine

final class ExpenseViewModel: ObservableObject {
    
    var title: String
    
    init(title: String, expenses: [ExpenseCardView.DisplayItem]) {
        self.title = title
        self.expenses = expenses
    }
    
    @Published var expenses : [ExpenseCardView.DisplayItem] = []

    func addExpense(_ expense: ExpenseCardView.DisplayItem) {
        expenses.append(expense)
    }

}
