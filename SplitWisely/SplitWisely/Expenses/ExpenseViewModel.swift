//
//  ExpenseViewModel.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 03/10/25.
//

import SwiftUI
import Combine

final class ExpenseViewModel: ObservableObject {
    
    @Published var groupDetail: GroupDisplayItem
    @Published var expenses : [ExpenseCardView.DisplayItem] = []
    var title: String
    
    init(group: GroupDisplayItem, expenses: [ExpenseCardView.DisplayItem]) {
        self.groupDetail = group
        self.title = group.name
        self.expenses = expenses
    }
    

    func addExpense(_ expense: ExpenseCardView.DisplayItem) {
        expenses.append(expense)
    }

}
