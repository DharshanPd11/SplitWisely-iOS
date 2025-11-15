//
//  SelectPayerView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 02/11/25.
//

import SwiftUI
import Combine

final class PayerViewModel: ObservableObject {
        
    @Published var participants : [ParticipantCardView.DisplayItem] = DummyData.participants
    @Published var searchText: String = ""
    @Published var selectedPayer: ParticipantCardView.DisplayItem?
    
    var searchedParticipants: [ParticipantCardView.DisplayItem] {
        guard !searchText.isEmpty else {
            return participants
        }
        return participants.filter {
            $0.name.lowercased().localizedCaseInsensitiveContains(searchText.lowercased())
        }
    }
    
    func selectedPayer(with id: Int) {
        guard let index = participants.firstIndex(where: { $0.id == id }) else { return }
        
        let current = participants[index]
        selectedPayer = current
        
        switch current.trailingView {
        case .multiSelect(isSelected: true):
            participants[index].trailingView = .multiSelect(isSelected: false)
        default:
            participants[index].trailingView = .multiSelect(isSelected: true)
        }
    }

}

struct SelectPayerView: View {
    
    @ObservedObject var viewModel: PayerViewModel
    @Binding var didFinishpickingPayer: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.searchedParticipants){ user in
                    ParticipantCardView(id: user.id, item: user)
                        .onTapGesture {
                            viewModel.selectedPayer(with: user.id)
                            didFinishpickingPayer = true
                            dismiss()
                        }
                }
            }
            .navigationTitle(Text("Select Payer"))
            .navigationBarTitleDisplayMode(.inline)
            .cancelToolBar {
                dismiss()
            }
            .searchable(text: $viewModel.searchText)
        }
    }
}

#Preview {
    @Previewable @State var payer = false
    SelectPayerView(viewModel: PayerViewModel(), didFinishpickingPayer: $payer)
}
