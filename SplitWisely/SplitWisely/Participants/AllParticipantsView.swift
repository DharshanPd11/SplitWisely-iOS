//
//  AllParticipantsView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 12/10/25.
//

import SwiftUI

public struct AllParticipantsView: View {
    
    @ObservedObject var viewModel: AllParticipantsViewModel
    @Binding var didFinishPickingParticipants: Bool
    @Environment(\.dismiss) var dismiss

    public var body: some View {
        NavigationStack {
            List {
                ForEach(ParticipantType.allCases, id: \.self) { type in
                    if let participants = viewModel.groupedParticipants[type], !participants.isEmpty {
                        Section(header: Text(type.rawValue)) {
                            ForEach(participants) { participant in
                                ParticipantCardView(id: participant.id, item: participant)
                                    .padding(.horizontal)
                                    .onTapGesture {
                                        viewModel.selectedParticipant(with: participant.id)
                                    }
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Participants")
            .navigationBarTitleDisplayMode(.inline)
            .cancelDoneToolbar(onCancel: { dismiss() },
                               onDone: {
                didFinishPickingParticipants = true
                dismiss()
            })
            .searchable(text: $viewModel.searchText, prompt: "Search")
     
        }
    }

}

#Preview {
    @Previewable @State var didFinishPickingParticipants = false
    AllParticipantsView(viewModel: AllParticipantsViewModel(participants: DummyData.participants), didFinishPickingParticipants: $didFinishPickingParticipants )
}
