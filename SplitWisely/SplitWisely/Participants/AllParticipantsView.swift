//
//  AllParticipantsView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 12/10/25.
//

import SwiftUI
import Combine

final class AllParticipantsViewModel: ObservableObject{
    
    @Published var participants : [ParticipantCardView.DisplayItem] = []
    @Published var type: ParticipantTrailingViewType = .singleSelect(isSelected: true)
    
    init(participants: [ParticipantCardView.DisplayItem]) {
        self.participants = participants
    }
    
    func getSelectedParticipants() -> [ParticipantCardView.DisplayItem] {
        var selectedParticipants: [ParticipantCardView.DisplayItem] = []
        for participant in participants {
            switch participant.trailingView {
            case .multiSelect(isSelected: true):
                selectedParticipants.append(participant)
            case .singleSelect(isSelected: true):
                selectedParticipants.append(participant)
            default:
                break
            }
        }
        return selectedParticipants
    }
    
    func selectedParticipant(at index: Int) {
        guard participants.indices.contains(index) else { return }
        let current = participants[index]
        switch current.trailingView {
        case .multiSelect(isSelected: true):
            participants[index].trailingView = .multiSelect(isSelected: false)
        default:
            participants[index].trailingView = .multiSelect(isSelected: true)
        }
    }
}

public struct AllParticipantsView: View {
    
    @ObservedObject var viewModel: AllParticipantsViewModel
    @Environment(\.dismiss) var dismiss

    public var body: some View {
        NavigationStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    LazyVStack(spacing: 25) {
                        ForEach(Array(viewModel.participants.enumerated()), id: \.element.id) { index, participant in
                            ParticipantCardView(id: participant.id, item: participant)
                                .padding(.horizontal)
                                .onTapGesture {
                                    viewModel.selectedParticipant(at: index)
                                }
                                .buttonStyle(.plain)
                        }
                    }
                    .padding(.top)
                }
            }
            .navigationTitle("Participants")
            .navigationBarTitleDisplayMode(.inline)
            .cancelDoneToolbar(onCancel: {dismiss()}, onDone: {
                dismiss()
            })
        }

    }
}

#Preview {
    AllParticipantsView(viewModel: AllParticipantsViewModel(participants: DummyData.participants))
}
