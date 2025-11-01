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
}

public struct AllParticipantsView: View {
    
    @ObservedObject var viewModel: AllParticipantsViewModel
    @Environment(\.dismiss) var dismiss

    public var body: some View {
        NavigationSplitView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    //                GroupDetailTitleView(groupName: $viewModel.title)
                    LazyVStack(spacing: 25) {
                        ForEach(viewModel.participants) { participant in
                            NavigationLink {
                                // ExpenseDetailView()
                            } label: {
                                ParticipantCardView(id: participant.id, item: participant)
                                    .padding(.horizontal)
                                
                            }.buttonStyle(.plain)
                        }
                    }
                }
                .padding(.top)
            }
            .navigationTitle("Participants")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        detail: {
            
        }
    }
}

#Preview {
    AllParticipantsView(viewModel: AllParticipantsViewModel(participants: DummyData.participants))
}
