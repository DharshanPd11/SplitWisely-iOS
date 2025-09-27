//
//  GroupsView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 27/09/25.
//

import SwiftUI

struct GroupsView: View {
    let rows: [GroupDisplayCardView] = [GroupDisplayCardView(id: 0, item: GroupDisplayItem(id: "0", icon: "", name: "Munnar", status: .settled)),GroupDisplayCardView(id: 1, item: GroupDisplayItem(id: "0", icon: "", name: "New Delhi", expense: Amount(value: 100, currencyCode: "USD"), status: .pending)),GroupDisplayCardView(id: 2, item: GroupDisplayItem(id: "0", icon: "", name: "Jammu and Kashmir", expense: Amount(value: -100, currencyCode: "USD"), status: .incoming)),GroupDisplayCardView(id: 3, item: GroupDisplayItem(id: "0", icon: "", name: "Andaman and Nicobar", status: .noExpense)), GroupDisplayCardView(id: 0, item: GroupDisplayItem(id: "0", icon: "", name: "Munnar", status: .settled)),GroupDisplayCardView(id: 1, item: GroupDisplayItem(id: "0", icon: "", name: "New Delhi", expense: Amount(value: 100, currencyCode: "USD"), status: .pending)),GroupDisplayCardView(id: 2, item: GroupDisplayItem(id: "0", icon: "", name: "Jammu and Kashmir", expense: Amount(value: -100, currencyCode: "USD"), status: .incoming)),GroupDisplayCardView(id: 3, item: GroupDisplayItem(id: "0", icon: "", name: "Andaman and Nicobar", status: .noExpense))]
    
    var body: some View {
        NavigationSplitView {
            List(rows) { group in
                NavigationLink {
//                    DetailView()
                } label: {
                    group
                }
            }
//            .listStyle(.plain)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .navigationTitle("Your Groups")
            .navigationSubtitle("Tap to open")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "arrow.up.and.down.text.horizontal")
                    }
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                }
            }

            
        }
        
        detail: {
            Text("Select a Group to view details")
        }
    }
}

#Preview {
    Group{
        GroupsView()
    }
}
