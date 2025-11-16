//
//  UIFactory.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 01/11/25.
//

import SwiftUI

struct UIFactory {
    
    struct ChipsView: View {
        let title : String
        let bg: Color?
        let onRemove: (() -> Void)?
        
        var body: some View {
            ZStack{
                HStack{
                    Text(title)
                        .font(.caption)
                    if let onRemove = onRemove {
                        Button{
                            withAnimation{
                                onRemove()
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 15, height: 15)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding()
            .frame(height: 25)

            .background{
                if let bg = bg{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(bg)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.clear)
                }
                
            }
            .overlay(
                Capsule()
                    .stroke(Color.gray, lineWidth: 2)
            )
        }
    }
}


#Preview{
    UIFactory.ChipsView(title: "A big title", bg: Color.blue, onRemove: {})
}
