//
//  GroupType.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 02/10/25.
//

import SwiftUI

struct GroupTypeDisplayable: Identifiable {
    let id = UUID()
    var type: GroupType
    let systemName: String
    let description: String
}

enum GroupType: String, CaseIterable {
    case trip
    case couple
    case friends
    case others
    case home
    case none
}

struct GroupTypeDetailView: View {
    let type: GroupType
    
    var body: some View {
        switch type {
        case .trip:
            GroupTypeTripSupplementView()
                .background(Color(.secondarySystemBackground))
                .transition(.move(edge: .leading).combined(with: .opacity))

        default:
            Text("Select an group type to add more details")
                .padding(.leading)
                .italic()
                .font(.caption)
                .transition(.move(edge: .leading).combined(with: .opacity))

        }
        
    }
}

struct GroupModel{
    var name: String
    var displayImage: Data?
    var type: GroupType
    var members: [String]
    var createdAt: Date
    var createdBy: String
    
    var tripDatesAdded: Bool
    var startDate: Date?
    var endDate: Date?
    
}
