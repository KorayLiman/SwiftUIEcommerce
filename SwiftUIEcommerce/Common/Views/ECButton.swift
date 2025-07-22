//
//  ECButton.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 14.07.2025.
//

import SwiftUI

struct ECTextButton: View {
    let label: LocalizedStringKey
    let action: () -> Void
    let maxWidth: CGFloat?
    
    init(label: LocalizedStringKey, maxWidth: CGFloat? = nil, action: @escaping () -> Void) {
        self.label = label
        self.maxWidth = maxWidth
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(maxWidth: maxWidth)
                .font(.body)
                .foregroundColor(.accentColor)
        }
    }
}

struct ECFilledButton: View {
    let label: LocalizedStringKey
    let action: () -> Void
    let maxWidth: CGFloat?
    
    init(label: LocalizedStringKey, maxWidth: CGFloat? = nil, action: @escaping () -> Void) {
        self.label = label
        self.maxWidth = maxWidth
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(maxWidth: maxWidth)
                .font(.headline)
                .foregroundColor(.onAccent)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.accentColor)
                .cornerRadius(12)
        }
    }
}
