//
//  ExpenseDisplayCardView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 03/10/25.
//

import SwiftUI

enum ExpenseType: String, Codable {
    case borrowed
    case lent
    case notInvloved
    
    
    func title() -> String {
        switch self {
        case .borrowed:
            return "You Borrowed"
        case .lent:
            return "You Lent"
        case .notInvloved:
            return "Not involved"
        }
    }
}

struct ExpenseCardView: View {
    
    struct DisplayItem: Identifiable{
        var id: Int
        var title: String
        var description: String
        var image: Image?
        var expense: Amount?
        var type: ExpenseType
        var date: Date
    }
   
    var id: Int
    var item: DisplayItem
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .center){
                Text(item.date.formatted(.dateTime.month(.abbreviated)))
                    .font(.headline)
                Text(item.date.formatted(.dateTime.day()))
            }
            .foregroundStyle(.secondary)
            .lineLimit(1)
            
            if let image = item.image {
                image
                    .resizable()
                    .frame(width: 48, height: 48)
            } else {
                Image(systemName: "fork.knife.circle.fill")
                    .resizable()
                    .frame(width: 48, height: 48)
            }


            VStack(alignment: .leading){
                Text(item.title)
                    .lineLimit(2)
                    .font(.headline)
                Text(item.description)
                    .lineLimit(1)
                    .font(.subheadline)
            }
            .truncationMode(.tail)

            Spacer()
            
            if item.type == .borrowed || item.type == .lent{
                if let expense = item.expense {
                    VStack(alignment: .trailing) {
                        Text(item.type.title())
                            .font(.callout)
                            .fontWeight(.thin)
                        Text("\(expense.formatted)")
                            .font(.headline)
                            .foregroundColor(item.expense?.color)
                    }
                }
            } else {
                Text(item.type.title())
                    .font(.callout)
                    .fontWeight(.thin)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
        )
    }
}

#Preview {
    ExpenseCardView(id: 0, item: ExpenseCardView.DisplayItem(id: 0, title: "Lunch Bill", description: "Day 1 lunch at Taj Coram", expense: Amount(value: 1000, currencyCode: "INR"), type: ExpenseType.borrowed, date: Date()))
}
