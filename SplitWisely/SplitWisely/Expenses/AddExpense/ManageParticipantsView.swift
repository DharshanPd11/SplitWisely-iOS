//
//  ManageParticipantsView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 01/11/25.
//

import SwiftUI

struct ManageParticipantsView: View {
    
    @ObservedObject var addExpenseVM: AddExpenseViewModel
    @State var presentAddParticipantsSheet = false

    var body: some View {
        VStack{
            HStack{
                ParticipantsCollectionView(presentAddParticipantsSheet: $presentAddParticipantsSheet, selectedParticipant: $addExpenseVM.expense.participants)
                Spacer()
            }
                .padding(.bottom)
                .onChange(of: presentAddParticipantsSheet) { _, shouldPresent in
                    if shouldPresent {
                        addExpenseVM.showAddParticipant()
                        presentAddParticipantsSheet = false
                    }
                }
            
            Divider()
                .frame(maxWidth: .infinity)
                .background(Color.primary)
        }
        .padding(.bottom)
    }
}

enum ChipItem: Identifiable {
    case participant(ParticipantCardView.DisplayItem)
    case add

    var id: String {
        switch self {
        case .add: return "add-chip"
        case .participant(let p): return "\(p.id)"
        }
    }
}

struct ParticipantsCollectionView: View {
    @Binding var presentAddParticipantsSheet: Bool
    @Binding var selectedParticipant: [ParticipantCardView.DisplayItem]

    var items: [ChipItem] {
        selectedParticipant.map { .participant($0) } + [.add]
     }
    
    var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                switch item{
                case .add:
                    Button {
                        presentAddParticipantsSheet = true
                    } label: {
                        UIFactory.ChipsView(title: "Add +", bg: Color.blue, onRemove: nil)
                    }
                    .buttonStyle(.plain)

                case .participant(let p):
                    let onRemoveClosure : ()-> Void = {
                        if index < items.count{
                            selectedParticipant.remove(at: index)
                        }
                    }
                    UIFactory.ChipsView(
                        title: p.name,
                        bg: nil,
                        onRemove: items.count != 2 ? onRemoveClosure : nil
                    )
                }
            }
        }
     .frame(maxWidth: .infinity)
    }
}

#Preview {
    AddExpenseView(viewModel: AddExpenseViewModel(group: GroupDisplayItem(id: 0, icon: "", name: "No Group", status: .noExpense), expenseGenerator: ExpenseExtractor()), onSave: {_ in })
}
