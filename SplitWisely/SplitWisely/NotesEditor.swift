//
//  NotesEditor.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 16/11/25.
//

import SwiftUI
import Combine


struct NotesEditor: View {
    @Binding var text: String
    @Environment(\.dismiss) var dismiss
    @FocusState private var isFocused: Bool
    @State private var initialText: String = ""
    
    var body: some View {
        NavigationStack {
            TextEditor(text: $text)
                .padding(.horizontal)
                .focused($isFocused)
                .padding(.top, 8)
                .navigationTitle("Notes")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    initialText = text
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isFocused = true
                    }
                }
                .cancelDoneToolbar(
                    onCancel: {
                        text = initialText
                        dismiss()
                    },
                    onDone: { dismiss() }
                )
        }
    }
}


#Preview{
   @Previewable @State var x = ""
    NotesEditor(text: $x)
}
