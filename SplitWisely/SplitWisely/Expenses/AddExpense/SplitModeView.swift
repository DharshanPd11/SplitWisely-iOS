//
//  SplitModeView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 22/11/25.
//

import SwiftUI


enum ExpenseSplitMode{
    case equal
    case shares
    case percent
    case manual
    
    var title: String{
        switch self{
        case .equal:
            return "Equal"
        case .shares:
           return "Shares"
        case .percent:
           return "Percent"
        case .manual:
           return "Manual"
        }
    }
}

struct SplitModeView: View {
    struct SplitModeDisplayable: Identifiable{
        var id: Int
        var name: String{
            type.title
        }
        var type: ExpenseSplitMode
    }
    
    let splitModes: [SplitModeDisplayable] = [
        .init(id: 0, type: .equal), .init(id: 1, type: .manual), .init(id: 2, type: .percent), .init(id: 3, type: .shares)
    ]
    
    var body: some View {
        NavigationStack{
            LazyVStack{
                LazyHGrid(rows: [GridItem(.flexible(minimum: 50, maximum: 100), spacing: 30)]){
                    ForEach(splitModes) { mode in
                        Button {
                            //
                        } label: {
                            Text("\(mode.name)")
                        }
                        .buttonStyle(.bordered)
                        .buttonStyle(.plain)
                        .buttonBorderShape(.roundedRectangle)
                    }
                }
            }
            .navigationTitle("Split Mode")
            .navigationBarTitleDisplayMode(.inline)
            .cancelDoneToolbar(onCancel: {}, onDone: {})
        }
        
    }
}


#Preview{
    SplitModeView()
}
