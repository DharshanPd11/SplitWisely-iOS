//
//  ParticipantCardView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 12/10/25.
//

import SwiftUI


public struct ParticipantCardView: View {
    var id: Int
    var item: DisplayItem
    
    struct DisplayItem: Identifiable{
        var id: Int
        var name: String
        var description: String?
        var image: Image?
        var expense: Amount?
        var trailingView: ParticipantTrailingViewType
    }

    public var body: some View {
    
        HStack {
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
                Text(item.name)
                    .lineLimit(1)
                    .font(.headline)
                if let desc = item.description, desc.isEmpty == false {
                    Text(desc)
                        .lineLimit(1)
                        .font(.subheadline)
                }
            }
            .truncationMode(.tail)
            
            Spacer()
            item.trailingView.view
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
        )
    }
}

enum ParticipantTrailingViewType {
    case none
    case multiSelect(isSelected: Bool)
    case singleSelect(isSelected: Bool)
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .none:
            EmptyView()
        case .multiSelect(let isSelected):
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isSelected ? .blue : .gray)
        case .singleSelect(let isSelected):
            Image(systemName: isSelected ? "checkmark" : "plus")
                .foregroundColor(.green)
        }
    }
}

#Preview {
    ParticipantCardView(id: 0, item: ParticipantCardView.DisplayItem(id: 0, name: "Manjaarika Kandallu Ravichandscsacsilcjklakscnskalnckasncksancksanclkasnclksa", description: "SOmething", image: Image(systemName: "person.circle"), expense: nil, trailingView: .multiSelect(isSelected: true)))
}

