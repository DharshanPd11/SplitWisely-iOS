//
//  AddExpenseViewModel.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 23/11/25.
//

import Foundation
import Combine
import SwiftUI

final class AddExpenseViewModel: ObservableObject {
    
    @Published var expense: Expense
        
    @Published var selectPayerVM: PayerViewModelProtocol
    @Published var participantsVM: AllParticipantsViewModelProtocol
    @Published var splitVM: SplitViewModelProtocol

    @Published var activeSheet: AddExpenseViewPresentables? = nil
        
    private let expenseGenerator: ExpenseExtractionProtocol
    
    init(group: GroupDisplayItem, expenseGenerator: ExpenseExtractionProtocol, selectPayerVM: PayerViewModelProtocol, participantsVM: AllParticipantsViewModelProtocol, splitVM: SplitViewModelProtocol ) {
        self.selectPayerVM = selectPayerVM
        self.participantsVM = participantsVM
        self.splitVM = splitVM
        self.expense = Expense(id: UUID(),
                               group: group, name: "",
                               amount: 0.00, currency: AllCurrencies().currentCurrency,
                               paidBy: DummyData.participants[0],
                               splitMode: .equal, participants: DummyData.participants, addedDate: Date())
        self.expenseGenerator = expenseGenerator
    }
    
    func getSplitViewModel() -> SplitViewModelProtocol {
        splitVM.splitMode = expense.splitMode
        splitVM.totalToBeSplit = Amount(value: expense.amount, currencyCode: expense.currency.symbol)
        return splitVM
    }
    
    func addParticipant(_ participant: ParticipantCardView.DisplayItem) {
        expense.participants.append(participant)
    }
    
    func addExpense() -> ExpenseCardView.DisplayItem{
        let newExpense = ExpenseCardView.DisplayItem(id: DummyData.expenses.count + 1, title: expense.name, description: expense.notes, expense: Amount(value: expense.amount, currencyCode: expense.currency.symbol), type: ExpenseInvolvementType.borrowed, date: Date())
        return newExpense
    }
    
    func showSelectCurrency() {
        activeSheet = .selectCurrency
    }

    func showSelectPayerSheet(){
        activeSheet = .payer
    }
    
    func showAddParticipant() {
        activeSheet = .addParticipant
    }
    
    func showDatePickerView() {
        activeSheet = .datePicker
    }
    
    func showExpenseSplitView() {
        activeSheet = .splitModeView
    }

    func dismiss() {
        activeSheet = nil
    }
    
    func selected(image: UIImage){
        expense.receiptImage = image
        if expenseGenerator.isDeviceAICompatible(){
            let textRecognizer = TextRecognizer()
            textRecognizer.extractText(from: image) { extractedText in
                Task { @MainActor in
                    await self.process(text: extractedText)
                }
            }
        }
    }
    
    @MainActor
    private func process(text: String) async {
        do {
            let exp = try await expenseGenerator.extractExpense(from: text)
            guard let exp else { return }

            expense.name = exp.title
//            currency = exp.currency
            expense.amount = exp.amount
        } catch {
            print("❌ Failed to extract expense:", error)
        }
    }

}
