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
                ParticipantsCollectionView(presentAddParticipantsSheet: $presentAddParticipantsSheet, selectedParticipant: $addExpenseVM.participants)
                Spacer()
            }
                .padding(.bottom)
                .onChange(of: presentAddParticipantsSheet) { _, shouldPresent in
                    if shouldPresent {
                        addExpenseVM.showAddParticipant()
                    }
                }
            
            Divider()
                .frame(maxWidth: .infinity)
                .background(Color.primary)
        }
        .padding(.bottom)
    }
}

struct ParticipantsCollectionView: View {
    @Binding var presentAddParticipantsSheet: Bool
    @Binding var selectedParticipant: [ParticipantCardView.DisplayItem]

    var columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(Array(selectedParticipant.enumerated()), id: \.element.id) { index, participant in
                UIFactory.ChipsView(
                    title: participant.name,
                    bg: nil,
                    onRemove: {
                        selectedParticipant.remove(at: index)
                    }
                )
                if index == selectedParticipant.count - 1 {
                    UIFactory.ChipsView(title: "Add +", bg: Color.blue , onRemove: nil)
                        .onTapGesture {
                            presentAddParticipantsSheet = true
                        }
                }
            }
        }
     .frame(maxWidth: .infinity)
    }
}

#Preview {
    AddExpenseView(viewModel: AddExpenseViewModel())
}
