//
//  CancelDoneToolbarModifier.swift
//  SplitWisely
//
//  Created by Priyadharshan Raja on 26/10/25.
//

import SwiftUI

struct CancelDoneToolbarModifier: ViewModifier {
    var onCancel: () -> Void
    var onDone: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: onCancel)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: onDone) {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.glassProminent)
                }
            }
    }
}

struct CancelViewModifier: ViewModifier {
    var onCancel: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: onCancel)
                }
            }
    }
}

struct DoneViewModifier: ViewModifier {
    var onDone: () -> Void
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: onDone) {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.glassProminent)
                }
            }
    }
}

extension View {
    func cancelDoneToolbar(onCancel: @escaping () -> Void, onDone: @escaping () -> Void) -> some View {
        self.modifier(CancelDoneToolbarModifier(onCancel: onCancel, onDone: onDone))
    }
    
    func cancelToolBar(onCancel: @escaping () -> Void) -> some View {
        self.modifier(CancelViewModifier(onCancel: onCancel))
    }
    
    func doneToolBar(onDone: @escaping () -> Void) -> some View {
        self.modifier(DoneViewModifier(onDone: onDone))
    }
}
