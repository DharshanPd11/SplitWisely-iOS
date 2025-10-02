//
//  GroupTypeTripSupplementView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 01/10/25.
//

import SwiftUI

struct GroupTypeTripSupplementView: View {
    
    @EnvironmentObject var viewModel: CreateGroupViewModel
    @State private var isOn : Bool = true

    let maxSelection = 2

    var body: some View {
        VStack {
            VStack{
                Toggle("Add Trip dates", isOn: $isOn)
                Text("When on you and your friend will be notified about the trip expenses base d on the dates you set")
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.bottom)
            .animation(.smooth, value: isOn)
            if isOn {
                VStack {
                    DatePicker("Start date", selection: $viewModel.startDate, in: ...viewModel.endDate, displayedComponents: .date)
                    DatePicker("End date", selection: $viewModel.endDate, in: viewModel.startDate..., displayedComponents: .date)
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(.smooth, value: isOn)
        .padding()
    }
}

#Preview{
    GroupTypeTripSupplementView()
}
