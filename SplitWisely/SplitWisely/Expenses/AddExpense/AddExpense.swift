//
//  CreateExpense.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 05/10/25.
//

import SwiftUI
import Combine
import FoundationModels

enum ExpenseType {
    case medics
    case food
    case entertainment
    case clothing
    case transport
    case none
}

final class AddExpenseViewModel: ObservableObject {
    
    @Published var expense: Expense
        
    @Published var selectPayerVM = PayerViewModel()
    @Published var participantsVM = AllParticipantsViewModel(participants: DummyData.participants)
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
    
    func addParticipant(_ participant: ParticipantCardView.DisplayItem) {
        expense.participants.append(participant)
    }
    
    func addExpense() -> ExpenseCardView.DisplayItem{
        let newExpense = ExpenseCardView.DisplayItem(id: DummyData.expenses.count + 1, title: expense.name, description: expense.notes, expense: Amount(value: expense.amount, currencyCode: expense.currency.code), type: ExpenseInvolvementType.borrowed, date: Date())
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
    
    func showNotesView() {
        activeSheet = .notes
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

struct AddExpenseView: View {
    
    @ObservedObject var viewModel: AddExpenseViewModel

    @State var name: String = ""
    @State var amount: String = ""
    @State var didFinishPickingParticipants: Bool = false
    @State var didFinishPickingPayer: Bool = false

    var onSave: (ExpenseCardView.DisplayItem) -> Void
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Field?

    enum Field {
        case title, amount
    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 5){
                
                ManageParticipantsView(addExpenseVM: viewModel)
                
                HStack {
                    ZStack{
                        Image(systemName: "list.bullet.rectangle.portrait")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.background)
                            .frame(width: 35, height: 35)
                    }
                    .frame(width: 45, height: 45)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .shadow(radius: 5, y: 5)
                        
                    }
                    VStack{
                        TextField("Enter Expense Name", text: $name)
                            .font(.title2)
                            .padding(.top)
                            .focused($focusedField, equals: .title)
                        Divider()
                            .frame(height: 1)
                            .overlay(.pink)
                    }
                    .padding(.bottom)
                    .padding(.leading)
                    
                }
                HStack {
                    Button {
                        viewModel.showSelectCurrency()
                    } label: {
                        ZStack{
                            Text(viewModel.expense.currency.symbol)
                                .font(.system(size: 100))
                                .minimumScaleFactor(0.1)
                                .lineLimit(1)
                                .scaledToFit()
                                .foregroundStyle(.background)
                        }
                    }
                    .frame(width: 45, height: 45)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .shadow(radius: 5, y: 5)
                    }
                    VStack{
                        TextField("0.00", text: $amount)
                            .font(.title)
                            .fontWeight(.bold)
                            .keyboardType(.decimalPad)
                            .focused($focusedField, equals: .amount)
                            .font(.title2)
                            .padding(.top)
                        Divider()
                            .frame(height: 1)
                            .overlay(.pink)
                    }
                    .padding(.bottom)
                    .padding(.leading)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                
                HStack{
                    Text("Paid by: ")
                    
                    Button(viewModel.expense.paidBy.name, role: .confirm, action: {
                        viewModel.showSelectPayerSheet()
                    })
                    .buttonStyle(.glass)
                    
                    Text("and split ")
                    
                    Button("\(viewModel.expense.splitMode.title)", role: .confirm, action: {
                        viewModel.showAddParticipant()
                    })
                    
                    .buttonStyle(.glass)
                }
                .padding(.top)
                .font(.caption)
                
                if let _ = viewModel.expense.receiptImage {
                    HStack{
                        Image(systemName: "paperclip")
                        Text("Image Attached")
                    }
                    .padding()
                }
                Spacer()
                ExpenseAccessoryView(expenseAccessoryViewModel: viewModel)
            }
            .onAppear {
                focusedField = .title
            }
            .padding()
            .padding()
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .cancelDoneToolbar(onCancel: {dismiss()}, onDone: {
                let newExpense = viewModel.addExpense()
                onSave(newExpense)
                dismiss()
            })
            
            .fullScreenCover(item: $viewModel.activeSheet, onDismiss: didDismiss) { item in
                switch item {
                case .selectCurrency:
                    AllCurrenciesView(selectedCurrency: $viewModel.expense.currency)
                case .addParticipant:
                    AllParticipantsView(viewModel: viewModel.participantsVM, didFinishPickingParticipants: $didFinishPickingParticipants)
                case .datePicker:
                    ExpenseDateView(expenseDate: $viewModel.expense.addedDate)
                case .selectGroup:
                    GroupsSelectionView(selectedGroup: $viewModel.expense.group, viewModel: GroupsViewModel())
                case .payer:
                    SelectPayerView(viewModel: viewModel.selectPayerVM, didFinishpickingPayer: $didFinishPickingPayer)
                case .camera:
                    PhotoCaptureView(viewModel: viewModel)
                case .notes:
                    NotesEditor(text: $viewModel.expense.notes)
                default:
                    ExpenseDateView(expenseDate: $viewModel.expense.addedDate)
                }
            }
            .onChange(of: didFinishPickingParticipants, {
                viewModel.expense.participants = viewModel.participantsVM.getSelectedParticipants()
            })
            .onChange(of: didFinishPickingPayer, {
                viewModel.expense.paidBy = viewModel.selectPayerVM.selectedPayer ?? DummyData.participants[0]
            })
            .onChange(of: name, {
                viewModel.expense.name = name
            })
            .onChange(of: amount, {
                if let decimalValue = Decimal(string: amount) {
                    viewModel.expense.amount = decimalValue
                }
            })
        }
    }
    
    func didDismiss() {
        
    }
}



enum AddExpenseViewPresentables: Identifiable {
    case selectCurrency
    case addParticipant
    case datePicker
    case selectGroup
    case attachPhotos
    case payer
    case camera
    case notes

    var id: String {
        switch self {
        case .selectCurrency: return "selectCurrency"
        case .addParticipant: return "addParticipant"
        case .datePicker: return "datePicker"
        case .selectGroup: return "selectGroup"
        case .attachPhotos: return "attachPhotos"
        case .notes: return "notes"
        case .payer: return "Payer"
        case .camera: return "camera"
        }
    }
}

enum PaymentSplitMode: Identifiable {
    case equal
    case custom
    case percent
    case shares
    case adjustments
    
    var id: String{
        switch self {
        case .equal: return "equal"
        case .custom: return "custom"
        case .percent: return "percent"
        case .shares: return "shares"
        case .adjustments: return "adjustments"
        }
    }
    
    var title: String{
        switch self {
        case .equal: return "Equally"
        default:
            return "Unequally"
        }
    }
}

#Preview {
    AddExpenseView(viewModel: AddExpenseViewModel(group: GroupDisplayItem(id: 0, icon: "", name: "No Group", status: .noExpense), expenseGenerator: ExpenseExtractor()), onSave: {_ in
    })
}
