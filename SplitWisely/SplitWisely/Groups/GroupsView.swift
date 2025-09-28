//
//  GroupsView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 27/09/25.
//

import SwiftUI

struct GroupsView: View {
    @State private var createGroupIsPresenting = false
    @ObservedObject private var viewModel: GroupsViewModel = GroupsViewModel()
    
    var rows: [GroupDisplayCardView] = []
    
    var body: some View {
        
        NavigationSplitView {
            List(viewModel.groups) { group in
                NavigationLink {
//                    DetailView()
                } label: {
                    GroupDisplayCardView(id: group.id, item: group)
                }
            }
//            .listStyle(.plain)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .navigationTitle("Your Groups")
            .navigationSubtitle("Tap to open")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "arrow.up.and.down.text.horizontal")
                    }
                    Button(action: {
                        createGroupIsPresenting = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
        detail: {
            Text("Select a Group to view details")
        }
        .fullScreenCover(isPresented: $createGroupIsPresenting,
                         onDismiss: didDismiss) {
            CreateGroup{ newGroup in
                viewModel.addGroup(newGroup)
            }
        }
    }
    
    func didDismiss() {
        
    }

}

#Preview {
    Group{
        GroupsView()
    }
}
