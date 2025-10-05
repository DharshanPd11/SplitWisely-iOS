//
//  AllExpensesView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 03/10/25.
//

import SwiftUI

struct AllExpensesView: View {
    
    @State private var showAddExpenseSheet: Bool = false
    @ObservedObject var viewModel: ExpenseViewModel
    @State var selectedCurrency: Currency = AllCurrencies().currentCurrency

    var body: some View {
        
        NavigationSplitView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack() {
                    GroupDetailTitleView(groupName: $viewModel.title)
                    LazyVStack(spacing: 25) {
                        ForEach(viewModel.expenses) { expense in
                            NavigationLink {
                                // ExpenseDetailView()
                            } label: {
                                ExpenseCardView(id: expense.id, item: expense)
                                    .padding(.horizontal)
                                
                            }.buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        detail: {
            Text("Select a Group to view details")
        }

//        .navigationTitle("SIkkim Team Trip")
        .overlay(
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        showAddExpenseSheet = true
                    } label: {
                        Label("Add expense", systemImage: "plus")
                            .padding()
                            .frame(height: 44)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    .padding()
                }
            }
                .fullScreenCover(isPresented: $showAddExpenseSheet,
                                 onDismiss: didDismiss) {
                    CreateExpenseView(viewModel: CreateExpenseViewModel())
                }
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showAddExpenseSheet = true
                }) {
                    Image(systemName: "gearshape.fill")
                }
            }
        }
    }
    
    func didDismiss() {
        
    }
        
        
}


#Preview {
    AllExpensesView(viewModel: ExpenseViewModel(title: "group.name", expenses: DummyData().getExpenses()))
}

