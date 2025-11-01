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
        
    var body: some View {
        
        NavigationSplitView {
            List(viewModel.groups) { group in
                NavigationLink {
                    AllExpensesView(viewModel: ExpenseViewModel(group: group, expenses: DummyData().getExpenses()))
                } label: {
                    GroupDisplayCardView(id: group.id, item: group)
                }
            }

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


struct GroupsSelectionView: View {

    @Binding var selectedGroup: GroupDisplayItem
    @State var viewModel: GroupsViewModel
    @State private var searchText = ""
    @Environment(\.dismiss) var dismiss

    private var filteredGroups: [GroupDisplayItem] {
        if searchText.isEmpty {
            viewModel.groups
        } else {
            viewModel.groups.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack{
            
            List(filteredGroups){group in
                HStack {
                    if let image = group.image {
                        image
                            .resizable()
                            .frame(width: 50, height: 50)
                    } else {
                        Image(systemName: "airplane.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                    Text(group.name)
                        .padding()
                    
                }
                .frame(width: .infinity, height: .infinity)
                .onTapGesture {
                    selectedGroup = group
                    dismiss()
                }
            }
            .cancelToolBar {
                dismiss()
            }
        }
        .listStyle(.automatic)
        .searchable(text: $searchText, prompt: "Search groups")

    }
}

#Preview {
    @Previewable @State var displayItem = GroupDisplayItem(id: 0, icon: "", name: "No Group", status: .noExpense)
    Group{
        GroupsSelectionView(selectedGroup: $displayItem, viewModel: GroupsViewModel())
    }
}
