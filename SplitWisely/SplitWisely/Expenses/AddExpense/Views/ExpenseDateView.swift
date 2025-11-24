//
//  ExpenseDateView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 26/10/25.
//

import SwiftUI

struct ExpenseDateView: View { //TODO: Pending reccurance expense view handling
    @Binding var expenseDate: Date
    @Environment(\.dismiss) var dismiss
    @State private var tempSelectedDate: Date

    init(expenseDate: Binding<Date>) {
        self._expenseDate = expenseDate
        self._tempSelectedDate = State(initialValue: expenseDate.wrappedValue)
    }
    
    public var body: some View {
        NavigationStack{
            DatePicker("Expense Date", selection: $tempSelectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
            Spacer()
            
            .navigationTitle("Expense Date")
            .navigationBarTitleDisplayMode(.inline)
            
            .cancelDoneToolbar(onCancel: {
                dismiss()
            }, onDone: {
                expenseDate = tempSelectedDate
                dismiss()
            })
        }
    }
}

#Preview {
    ExpenseDateView(expenseDate: .constant(Date()))
}
