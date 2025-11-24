//
//  PayerViewModel.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 24/11/25.
//

import Combine
import Foundation

protocol PayerViewModelProtocol: AnyObject {
    var selectedPayer: ParticipantCardView.DisplayItem? { get }
    var searchedParticipants: [ParticipantCardView.DisplayItem] { get }
    func selectedPayer(with id: Int)
}

final class PayerViewModel: ObservableObject, PayerViewModelProtocol {
        
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
