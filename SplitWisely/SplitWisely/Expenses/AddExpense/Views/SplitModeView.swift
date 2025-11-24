//
//  SplitModeView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 22/11/25.
//

import SwiftUI

struct SplitModeView: View {
    
    @ObservedObject var viewModel: SplitViewModel
    @Environment(\.dismiss) var dismiss
    
    struct SplitModeDisplayable: Identifiable{
        var id: Int
        var name: String{
            type.buttonTitle
        }
        var type: ExpenseSplitMode
    }
    
    let splitModes: [SplitModeDisplayable] = [
            .init(id: 0, type: .equal),
            .init(id: 3, type: .shares),
            .init(id: 1, type: .manual),
            .init(id: 2, type: .percent)
    ]
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Amount")
                Text("\(viewModel.totalToBeSplit.currencyCode) \(viewModel.totalToBeSplit.value)")
                    .font(.title)
                LazyHGrid(rows: [GridItem(.fixed(45), spacing: 20)]){
                    ForEach(splitModes) { mode in
                        Button {
                            withAnimation{
                                viewModel.splitMode = mode.type
                            }
                        } label: {
                            Text("\(mode.name)")
                                .frame(width: 80, height: 45)
                                .foregroundColor(.primary)
                                .background{
                                    RoundedRectangle(cornerSize: CGSize(width: 80, height: 45))
                                        .foregroundStyle(.secondary)
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .frame(maxHeight: 45)
                
                ParticipantSplitView(viewModel: viewModel)
            }
            .navigationTitle("Split Mode")
            .navigationBarTitleDisplayMode(.inline)
            .cancelDoneToolbar(onCancel: {
               dismiss()
            }, onDone: {})
            
        }
        
    }
}


struct ParticipantSplitView: View {

    @ObservedObject var viewModel: SplitViewModel
    
    var body: some View {
        VStack{
            List($viewModel.participants){ participant in
                Card(splitMode: $viewModel.splitMode, item: participant)
            }
            .scrollIndicators(.hidden)
            .listStyle(.grouped)
        }
    }
    
    struct Card: View {
        
        @Binding var splitMode: ExpenseSplitMode
        @Binding var item: Participant
        @State var amount = ""
        
        var isSelected: Bool {
            return item.amountOwed > 0
        }
        
        var body: some View {
            HStack {
                Image(systemName: "person.fill")
                    .resizable()
                    .clipShape(.circle)
                    .frame(width: 40, height: 40)
                    .padding(.trailing)
                
                VStack(alignment: .leading){
                    Text(item.name)
                        .lineLimit(1)
                        .font(.headline)
                }
                .truncationMode(.tail)
                Spacer()
                
                switch splitMode {
                case .equal:
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isSelected ? .blue : .gray)
                case .shares:
                    HStack{
                        Button{
                            if var shares = item.sharesOwed, shares > 0{
                                shares -= 1
                                item.sharesOwed = shares
                            }
                        } label: {
                            Text("-")
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle)

                        Text("\(item.sharesOwed ?? 0)")
                        Button{
                            if var shares = item.sharesOwed, shares > 0{
                                shares += 1
                                item.sharesOwed = shares
                            } else {
                                item.sharesOwed = 1
                            }
                        } label: {
                            Text("+")
                        }
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle)
                    }
                case .percent:
                    TextField("0.00", text: $amount)
                        .keyboardType(.decimalPad)
                        .frame(width: 60)
                        .font(.title2)
                        .underline(color: .white)
                case .manual:
                    TextField("0.00", text: $amount)
                        .keyboardType(.decimalPad)
                        .frame(width: 60)
                        .font(.title2)
                        .underline(color: .white)
                }
                
            }
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.clear))
            )
        }
    }
}

#Preview{
    SplitModeView(viewModel: SplitViewModel(splitMode: .manual, participants: DummyData.SplitParticipanta, totalToBeSplit: Amount(value: 2394, currencyCode: "INR"), shares: 0) )
}
