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
        
    @Published var selectPayerVM = PayerViewModel()
    @Published var participantsVM = AllParticipantsViewModel(participants: DummyData.participants)
    @Published var splitVM = SplitViewModel(splitMode: .equal, participants: DummyData.SplitParticipanta, totalToBeSplit: Amount(value: 0, currencyCode: AllCurrencies().currentCurrency.code))
    
    @Published var activeSheet: AddExpenseViewPresentables? = nil
        
    private let expenseGenerator: ExpenseExtractionProtocol
    
    init(group: GroupDisplayItem, expenseGenerator: ExpenseExtractionProtocol) {
        self.expense = Expense(id: UUID(),
                               group: group, name: "",
                               amount: 0.00, currency: AllCurrencies().currentCurrency,
                               paidBy: DummyData.participants[0],
                               splitMode: .equal, participants: DummyData.participants, addedDate: Date())
        self.expenseGenerator = expenseGenerator
    }
    
    func getSplitViewModel() -> SplitViewModel{
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
