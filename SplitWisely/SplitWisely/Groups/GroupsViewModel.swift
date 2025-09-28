//
//  GroupsViewModel.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 28/09/25.
//

import SwiftUI
import Combine

final class GroupsViewModel: ObservableObject {
    
    @Published var groups: [GroupDisplayItem] = [ GroupDisplayItem(id: 0, icon: "", name: "Munnar", status: .settled), GroupDisplayItem(id: 1, icon: "", name: "New Delhi", expense: Amount(value: 100, currencyCode: "USD"), status: .pending), GroupDisplayItem(id: 2, icon: "", name: "Jammu and Kashmir", expense: Amount(value: -100, currencyCode: "USD"), status: .incoming), GroupDisplayItem(id: 4, icon: "", name: "Andaman and Nicobar", status: .noExpense), GroupDisplayItem(id: 3, icon: "", name: "Munnar", status: .settled), GroupDisplayItem(id: 5, icon: "", name: "New Delhi", expense: Amount(value: 100, currencyCode: "USD"), status: .pending), GroupDisplayItem(id: 6, icon: "", name: "Jammu and Kashmir", expense: Amount(value: -100, currencyCode: "USD"), status: .incoming), GroupDisplayItem(id: 7, icon: "", name: "Andaman and Nicobar", status: .noExpense)]
    
    func addGroup(_ group: GroupDisplayItem) {
        groups.append(group)
    }
}
