//
//  ExpenseAccessoryView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 01/11/25.
//

import SwiftUI

struct ExpenseAccessoryView: View {
    
    @ObservedObject var expenseAccessoryViewModel: AddExpenseViewModel
    
    var body: some View {
        HStack{
            DateButton(expenseDate: $expenseAccessoryViewModel.expenseDate, toPresent: $expenseAccessoryViewModel.activeSheet)
            Spacer()
            GroupNameButton(group: $expenseAccessoryViewModel.group, toPresent: $expenseAccessoryViewModel.activeSheet)
            Spacer()
            OpenCameraButton(toPresent: $expenseAccessoryViewModel.activeSheet)
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
        @Binding var group: GroupDisplayItem
        @Binding var toPresent: AddExpenseViewPresentables?
        
        var body: some View {
            Button(action: {
                toPresent = .selectGroup
            }){
                Image(systemName: "person.3.fill")
                Text(group.name)
                    .font(.default)
                    .lineLimit(1)
            }
            .foregroundColor(.primary)
        }
    }
    struct OpenCameraButton: View {
        @Binding var toPresent: AddExpenseViewPresentables?

        var body: some View {
            Button(action: {
                toPresent = .camera
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
