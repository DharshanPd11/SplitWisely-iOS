//
//  CreateExpense.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 05/10/25.
//

import SwiftUI
import Combine
import Foundation

enum ExpenseType {
    case medics
    case food
    case entertainment
    case clothing
    case transport
    case none
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
                        viewModel.showExpenseSplitView()
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
                    if let allParticipantsVM = viewModel.participantsVM as? AllParticipantsViewModel {
                        AllParticipantsView(viewModel: allParticipantsVM, didFinishPickingParticipants: $didFinishPickingParticipants)
                    }
                case .datePicker:
                    ExpenseDateView(expenseDate: $viewModel.expense.addedDate)
                case .selectGroup:
                    GroupsSelectionView(selectedGroup: $viewModel.expense.group, viewModel: GroupsViewModel())
                case .payer:
                    if let selectPayerVM = viewModel.selectPayerVM as? PayerViewModel {
                        SelectPayerView(viewModel: selectPayerVM, didFinishpickingPayer: $didFinishPickingPayer)
                    }
                case .camera:
                    PhotoCaptureView(viewModel: viewModel)
                case .notes:
                    NotesEditor(text: $viewModel.expense.notes)
                case .splitModeView:
                    if let splitVM = viewModel.getSplitViewModel() as? SplitViewModel{
                        SplitModeView(viewModel: splitVM)
                    }
                default:
                    NotesEditor(text: $viewModel.expense.notes)
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
    case splitModeView
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
        case .splitModeView: return "splitModeView"
        }
    }
}

#Preview {
    let participantsVM = AllParticipantsViewModel(participants: DummyData.participants)
    let splitVM = SplitViewModel(splitMode: .equal, participants: DummyData.SplitParticipanta, totalToBeSplit: Amount(value: 0, currencyCode: AllCurrencies().currentCurrency.code), shares: 0)
    
    AddExpenseView( viewModel: AddExpenseViewModel(group: GroupDisplayItem(id: 0, icon: "", name: "No Group", status: .noExpense),
           expenseGenerator: ExpenseExtractor(),
           selectPayerVM: PayerViewModel(),
           participantsVM: participantsVM,
           splitVM: splitVM),
        onSave: {_ in
    })
}
