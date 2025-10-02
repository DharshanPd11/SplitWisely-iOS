//
//  GroupDisplayCardView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 27/09/25.
//

import SwiftUI

enum ExpenseStatus {
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

struct GroupDisplayItem: Identifiable{
    var id: Int
    var icon: String
    var name: String
    var image: Image?
    var expense: Amount?
    var status: ExpenseStatus
}

struct GroupDisplayCardView: View, Identifiable {
    var id: Int
    var item: GroupDisplayItem
    
    var body: some View {
        HStack {
            if let image = item.image {
                image
                    .resizable()
                    .frame(width: 50, height: 50)
            } else {
                Image(systemName: "airplane.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            
            Text(item.name)
                .padding()
                .lineLimit(2)
                .truncationMode(.tail)
            Spacer()
            
            if item.status == .incoming || item.status == .pending{
                if let expense = item.expense {
                    VStack(alignment: .trailing) {
                        Text("\(expense.formatted)")
                            .font(.headline)
                            .foregroundColor(item.expense?.color)
                        Text(item.status.title)
                            .font(.callout)
                            .fontWeight(.thin)
                    }
                }
            } else {
                Text(item.status.title)
                    .font(.callout)
                    .fontWeight(.thin)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
        )
    }
}

#Preview {
    let item = GroupDisplayItem(id: 0, icon: "", name: "MunnarMunnarMunnarMunnarMunnarMunnarMunnar", expense: Amount(value: -100, currencyCode: "INR") ,status: .incoming)
    GroupDisplayCardView(id: 0, item: item)
}
