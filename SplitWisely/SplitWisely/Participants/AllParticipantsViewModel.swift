//
//  AllParticipantsViewModel.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 24/11/25.
//


import Combine
import Foundation

protocol AllParticipantsViewModelProtocol: AnyObject {
    var groupedParticipants: [ParticipantType: [ParticipantCardView.DisplayItem]] { get }
    func selectedParticipant(with id: Int)
    func getSelectedParticipants() -> [ParticipantCardView.DisplayItem]
}

final class AllParticipantsViewModel: ObservableObject, AllParticipantsViewModelProtocol{
    
    @Published var participants : [ParticipantCardView.DisplayItem] = []
    @Published var type: ParticipantTrailingViewType = .singleSelect(isSelected: true)
    @Published var searchText: String = ""
    let availableGroups = GroupsViewModel().groups
    
    init(participants: [ParticipantCardView.DisplayItem]) {
        self.participants = participants
        self.convertGroupsIntoParticipantObject()
    }
    
    var groupedParticipants: [ParticipantType: [ParticipantCardView.DisplayItem]] {
        let filtered = searchText.isEmpty ? participants : participants.filter({ $0.name.lowercased().localizedCaseInsensitiveContains(searchText.lowercased())})
       return Dictionary(grouping: filtered, by: { $0.type ?? .individual })
    }
    
    private func convertGroupsIntoParticipantObject(){
        for group in availableGroups {
            let participantItem : ParticipantCardView.DisplayItem = .init(id: group.id, name: group.name, trailingView: .multiSelect(isSelected: false), type: .group)
            participants.append(participantItem)
        }
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
    
    func selectedParticipant(with id: Int) {
        guard let index = participants.firstIndex(where: { $0.id == id }) else { return }
        
        let current = participants[index]
        
        switch current.trailingView {
        case .multiSelect(isSelected: true):
            participants[index].trailingView = .multiSelect(isSelected: false)
        default:
            participants[index].trailingView = .multiSelect(isSelected: true)
        }
    }
}
