//
//  AllCurrenciesView.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 05/10/25.
//

import SwiftUI

struct AllCurrenciesView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var selectedCurrency: Currency
    @State private var searchText = ""
    @State private var filteredCurrencies: [Currency] = []
    @State private var list : [Currency] = AllCurrencies().load() ?? []
    

    var body: some View {
        
        NavigationStack{
            List(filteredCurrencies) { currency in
                Button {
                    selectedCurrency = currency
                    dismiss()
                } label: {
                    HStack{
                        Text(currency.name)
                        Text(currency.symbol_native)
                        Spacer()
                        Text(currency.symbol)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                }
                .buttonStyle(.plain)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Select Currency")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search currencies")

            .onChange(of: searchText) { _ in
                filterCurrencies()
            }
            .onAppear {
                if let all = AllCurrencies().load() {
                    list = all
                    filteredCurrencies = all
                }
            }
        }
    }
//
//    func dismiss() {
//
//    }
    
    private func filterCurrencies() {
        if searchText.isEmpty {
            filteredCurrencies = list
        } else {
            filteredCurrencies = list.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.code.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
//    @Previewable @State var selectedCurrency: Currency? = AllCurrencies().currentCurrency
//    AllCurrenciesView(selectedCurrency: selectedCurrency)
}
