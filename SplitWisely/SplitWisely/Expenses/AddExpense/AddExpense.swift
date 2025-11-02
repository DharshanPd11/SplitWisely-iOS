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

final class AddExpenseViewModel: ObservableObject {
    
    @Published var group: GroupDisplayItem = GroupDisplayItem(id: 0, icon: "", name: "No Group", status: .noExpense)
    @Published var name: String = ""
    @Published var amount: Decimal = 0.00
    @Published var currency: Currency = AllCurrencies().currentCurrency
    @Published var selectedImage: UIImage?
    @Published var selectedExpenseType: ExpenseType = .none
    @Published var addedDate: Date = Date()
    @Published var expenseDate: Date = Date()
    
    @Published var selectPayerVM = PayerViewModel()
    @Published var paidBy : ParticipantCardView.DisplayItem = DummyData.participants[0]
    
    @Published var participantsVM = AllParticipantsViewModel(participants: DummyData.participants)
    @Published var participants : [ParticipantCardView.DisplayItem] = DummyData.participants

    @Published var activeSheet: AddExpenseViewPresentables? = nil
    @Published var splitMode: PaymentSplitMode = .equal
    
    func addParticipant(_ participant: ParticipantCardView.DisplayItem) {
        participants.append(participant)
    }
    
    func selectGroupType(_ type: ExpenseType) {
        selectedExpenseType = type
    }
    
    func buildExpense() -> ExpenseCardView {
        ExpenseCardView(id: 0, item: ExpenseCardView.DisplayItem(id: 0, title: name, description: "", expense: Amount(value: amount, currencyCode: currency.code), type: ExpenseInvovementType.borrowed, date: Date()))
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

    func dismiss() {
        activeSheet = nil
    }
}

struct AddExpenseView: View {
    
    @ObservedObject var viewModel: AddExpenseViewModel

    @State var didFinishPickingParticipants: Bool = false
    @State var didFinishPickingPayer: Bool = false

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
                        TextField("Enter Expense Name", text: .constant(""))
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
                            Text(viewModel.currency.symbol)
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
                        TextField("0.00", text: .constant(""))
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
                    
                    Button(viewModel.paidBy.name, role: .confirm, action: {
                        viewModel.showSelectPayerSheet()
                    })
                    .buttonStyle(.glass)
                    
                    Text("and split ")

                    Button("\(viewModel.splitMode.title)", role: .confirm, action: {
                        viewModel.showAddParticipant()
                    })

                    .buttonStyle(.glass)
                }
                .padding(.top)
                .font(.caption)
                Spacer()
                ExpenseAccessoryView(expenseAccessoryViewModel: viewModel)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    focusedField = .title
                }
            }
            .padding()
            .padding()
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .cancelToolBar {
                dismiss()
            }
            
            .fullScreenCover(item: $viewModel.activeSheet, onDismiss: didDismiss) { item in
                switch item {
                case .selectCurrency:
                    AllCurrenciesView(selectedCurrency: $viewModel.currency)
                case .addParticipant:
                    AllParticipantsView(viewModel: viewModel.participantsVM, didFinishPickingParticipants: $didFinishPickingParticipants)
                case .datePicker:
                    ExpenseDateView(expenseDate: $viewModel.expenseDate)
                case .selectGroup:
                    GroupsSelectionView(selectedGroup: $viewModel.group, viewModel: GroupsViewModel())
                case.payer:
                    SelectPayerView(viewModel: viewModel.selectPayerVM, didFinishpickingPayer: $didFinishPickingPayer)
                default:
                    ExpenseDateView(expenseDate: $viewModel.expenseDate)
                }
            }
            .onChange(of: didFinishPickingParticipants, {
                viewModel.participants = viewModel.participantsVM.getSelectedParticipants()
            })
            .onChange(of: didFinishPickingPayer, {
                viewModel.paidBy = viewModel.selectPayerVM.selectedPayer ?? DummyData.participants[0]
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
//    ExpenseFormView()
    AddExpenseView(viewModel: AddExpenseViewModel())
}
