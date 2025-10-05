//
//  CreateExpense.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 05/10/25.
//

import SwiftUI
import Combine

enum ExpenseType {
    case medics
    case food
    case entertainment
    case clothing
    case transport
    case none
}

final class CreateExpenseViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var amount: Decimal = 0.00
    @Published var currency: Currency = AllCurrencies().currentCurrency
    @Published var selectedImage: UIImage?
    @Published var selectedExpenseType: ExpenseType = .none
    @Published var addedDate: Date = Date()
    @Published var expenseDate: Date = Date()
    
    
    
    func selectGroupType(_ type: ExpenseType) {
        selectedExpenseType = type
    }
    
    func buildGroup() -> ExpenseCardView {
        ExpenseCardView(id: 0, item: ExpenseCardView.DisplayItem(id: 0, title: name, description: "", expense: Amount(value: amount, currencyCode: currency.code), type: ExpenseInvovementType.borrowed, date: Date()))
    }
}

struct CreateExpenseView: View {
    
    @ObservedObject var viewModel: CreateExpenseViewModel
    
    @State var showCurrencies = false
    @State var selectedCurrency: Currency? = AllCurrencies().currentCurrency
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack{
            VStack {
                HStack {
                    ZStack{
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.background)
                            .frame(width: 35, height: 35)
                    }
                    .frame(width: 50, height: 50)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .shadow(radius: 5, y: 5)
                        
                    }
                    VStack{
                        TextField("Enter Expense Name", text: .constant(""))
                            .font(.title2)
                            .padding(.top)
                        Divider()
                            .frame(height: 2)
                            .overlay(.pink)
                    }
                    .padding(.leading)
                    
                }
                HStack {
                    Button {
                        showCurrencies = true
                    } label: {
                        ZStack{
                            Text(viewModel.currency.symbol)
                                .font(.system(size: 100))
                                .minimumScaleFactor(0.1)
                                .lineLimit(1)
                                .scaledToFit()
                                .foregroundStyle(.background)
                        }
                    }
                    .frame(width: 50, height: 50)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .shadow(radius: 5, y: 5)
                    }
                    VStack{
                        TextField("0.00", text: .constant(""))
                            .font(.title)
                            .fontWeight(.bold)
                            .keyboardType(.numbersAndPunctuation)
                            .font(.title2)
                            .padding(.top)
                        Divider()
                            .frame(height: 2)
                            .overlay(.pink)
                    }
                    .padding(.leading)
                    
                }
            }
            .navigationTitle("Add Expense")
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .padding()
            .fullScreenCover(isPresented: $showCurrencies,
                             onDismiss: didDismiss) {
                AllCurrenciesView(selectedCurrency: $viewModel.currency)
            }
        }
    }
    
    func didDismiss() {
        
    }
}


#Preview {
    CreateExpenseView(viewModel: CreateExpenseViewModel())
}
