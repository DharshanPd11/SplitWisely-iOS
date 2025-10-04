//
//  AllExpensesView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 03/10/25.
//

import SwiftUI

struct AllExpensesView: View {
    
    @State private var showAddExpenseSheet: Bool = false
    @ObservedObject var viewModel: ExpenseViewModel
        
    var body: some View {
        
        NavigationSplitView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack() {
                    GroupDetailTitleView(groupName: $viewModel.title)
                    LazyVStack(spacing: 25) {
                        ForEach(viewModel.expenses) { expense in
                            NavigationLink {
                                // ExpenseDetailView()
                            } label: {
                                ExpenseCardView(id: expense.id, item: expense)
                                    .padding(.horizontal)
                                
                            }.buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        detail: {
            Text("Select a Group to view details")
        }

//        .navigationTitle("SIkkim Team Trip")
    
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showAddExpenseSheet = true
                }) {
                    Image(systemName: "gearshape.fill")
                }
            }
        }

    }
}


#Preview {
    AllExpensesView(viewModel: ExpenseViewModel(title: "group.name", expenses: DummyData().getExpenses()))
}


struct GroupDetailTitleView: View {
    @Binding var groupName: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Image(systemName: "motorcycle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(.systemBackground))
                    )
                
                Text(groupName)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("You are all settled up in this group.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 12))
            Spacer()
        }
    }
}

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


