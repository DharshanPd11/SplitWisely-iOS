//
//  ContentView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 27/09/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        
        TabView {
            TabSection {
                Tab("Home", systemImage: "house") {
                    //              HomeView()
                }
                
                Tab("Groups", systemImage: "person.3.fill") {
                    GroupsView()
                }
                
                Tab("Activity", systemImage: "chart.bar.yaxis") {
                    //              ActivityView()
                }
                
                Tab("Account", systemImage: "person.crop.circle.fill") {
                    //              AccountView()
                }
            }
        }
        .tint(.red)
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    TabBarView()
}
