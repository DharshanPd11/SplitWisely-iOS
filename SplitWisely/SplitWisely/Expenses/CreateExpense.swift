//
//  CreateExpense.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 05/10/25.
//

import SwiftUI

struct CreateExpenseView: View {
    
    var body: some View {
        VStack {
            HStack {
                ZStack{
                    Image(systemName: "list.bullet.rectangle.portrait")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.background)
                        .frame(width: 35, height: 35)
                }
                .frame(width: 57, height: 57)
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
                ZStack{
                    Image(systemName: "dollarsign")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.background)
                        .frame(width: 35, height: 35)
                }
                .frame(width: 57, height: 57)
                .background{
                    RoundedRectangle(cornerRadius: 5)
                        .shadow(radius: 5, y: 5)
                }
                VStack{
                    TextField("0.00", text: .constant(""))
                        .font(.system(size: 26))
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
        .padding()
    }
}


#Preview {
    CreateExpenseView()
}
