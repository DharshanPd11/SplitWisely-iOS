//
//  GroupDetailTitleView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 05/10/25.
//

import SwiftUI

struct GroupDetailTitleView: View {
    @Binding var groupName: String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Image(systemName: "motorcycle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color(.systemBackground))
                    )
                
                Text(groupName)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("You are all settled up in this group.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                GroupDetailSegmentViews()
            }
            .padding()
            .clipShape(RoundedRectangle(cornerRadius: 12))
            Spacer()
        }
    }
}
