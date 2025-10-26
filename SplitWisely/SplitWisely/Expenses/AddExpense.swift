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
    
    @Published var name: String = ""
    @Published var amount: Decimal = 0.00
    @Published var currency: Currency = AllCurrencies().currentCurrency
    @Published var selectedImage: UIImage?
    @Published var selectedExpenseType: ExpenseType = .none
    @Published var addedDate: Date = Date()
    @Published var expenseDate: Date = Date()
    
    @Published var activeSheet: AddExpenseViewPresentables? = nil
    @Published var splitMode: PaymentSplitMode = .equal
    
    func selectGroupType(_ type: ExpenseType) {
        selectedExpenseType = type
    }
    
    func buildGroup() -> ExpenseCardView {
        ExpenseCardView(id: 0, item: ExpenseCardView.DisplayItem(id: 0, title: name, description: "", expense: Amount(value: amount, currencyCode: currency.code), type: ExpenseInvovementType.borrowed, date: Date()))
    }
    
    func showSelectCurrency() {
        activeSheet = .selectCurrency
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

    @State var selectedCurrency: Currency? = AllCurrencies().currentCurrency

    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Field?

    enum Field {
        case title, amount
    }
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 5){
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
                    
                    Button("John Doe", role: .confirm, action: {
                        viewModel.showAddParticipant()
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
                    AllParticipantsView(viewModel: AllParticipantsViewModel(participants: DummyData.init().participants))
                case .datePicker:
                    ExpenseDateView(expenseDate: $viewModel.expenseDate)
                default:
                    ExpenseDateView(expenseDate: $viewModel.expenseDate)
                }
            }
        }
    }
    
    func didDismiss() {
        
    }
}

struct ExpenseAccessoryView: View {
    
    @ObservedObject var expenseAccessoryViewModel: AddExpenseViewModel
    
    var body: some View {
        HStack{
            DateButton(expenseDate: $expenseAccessoryViewModel.expenseDate, toPresent: $expenseAccessoryViewModel.activeSheet)
            GroupNameButton()
            Spacer()
            OpenCameraButton()
            Spacer()
            NotesButton()
        }
    }
    
    struct DateButton: View {
        @Binding var expenseDate: Date
        @Binding var toPresent: AddExpenseViewPresentables?

        var body: some View {
            HStack{
                Button(action: {
                    toPresent = .datePicker
                }){
                    HStack(alignment: .center){
                        Image(systemName: "calendar")
                        Text(expenseDate.formatted(.dateTime.month(.abbreviated)))
                            .font(.headline)
                        Text(expenseDate.formatted(.dateTime.day()))
                    }
                    .lineLimit(1)
                }
                .foregroundColor(.primary)

            }
        }
    }
    struct GroupNameButton: View {
        var body: some View {
            Button(action: {
                //
            }){
                Image(systemName: "person.3.fill")
                Text("Group NameNameName")
                    .font(.default)
                    .lineLimit(1)
            }
            .foregroundColor(.primary)
        }
    }
    struct OpenCameraButton: View {
        var body: some View {
            Button(action: {
                //
            }) {
                Image(systemName: "camera.fill")
                    .foregroundColor(.primary)
            }
        }
    }
    struct NotesButton: View {
        var body: some View {
            Button(action: {
                //
            }) {
                Image(systemName: "pencil.and.list.clipboard")
                    .foregroundColor(.primary)
            }
        }
    }
}

enum AddExpenseViewPresentables: Identifiable {
    case selectCurrency
    case addParticipant
    case datePicker
    case selectGroup
    case attachPhotos
    case notes

    var id: String {
        switch self {
        case .selectCurrency: return "selectCurrency"
        case .addParticipant: return "addParticipant"
        case .datePicker: return "datePicker"
        case .selectGroup: return "selectGroup"
        case .attachPhotos: return "attachPhotos"
        case .notes: return "notes"
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
    AddExpenseView(viewModel: AddExpenseViewModel())
}
