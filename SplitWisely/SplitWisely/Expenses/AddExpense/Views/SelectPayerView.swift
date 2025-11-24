//
//  SelectPayerView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 02/11/25.
//

import SwiftUI

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
