//
//  GroupDetailSegments.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 05/10/25.
//

import SwiftUI

enum GroupDetailSegment {
    case settleUp
    case balances
    case totals
    case whiteBoard
    case tripPass
    case charts
    case export
    
    var title: String {
        switch self {
        case .settleUp:
            return "Settle Up"
        case .balances:
            return "Balances"
        case .totals:
            return "Totals"
        case .whiteBoard:
            return "White Board"
        case .tripPass:
            return "Trip Pass"
        case .charts:
            return "Charts"
        case .export:
            return "Export"
        }
    }
}

struct GroupDetailSegmentTitleView: View {
    var name: String
    var body: some View {
        Button(name) { }
            .buttonStyle(.bordered)
    }
}

struct GroupDetailSegmentViews: View {
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 12) {
                GroupDetailSegmentTitleView(name: GroupDetailSegment.settleUp.title)
                GroupDetailSegmentTitleView(name: GroupDetailSegment.balances.title)
                GroupDetailSegmentTitleView(name: GroupDetailSegment.totals.title)
                GroupDetailSegmentTitleView(name: GroupDetailSegment.whiteBoard.title)
                GroupDetailSegmentTitleView(name: GroupDetailSegment.tripPass.title)
                GroupDetailSegmentTitleView(name: GroupDetailSegment.charts.title)
                GroupDetailSegmentTitleView(name: GroupDetailSegment.export.title)
            }
        }
    }
}
