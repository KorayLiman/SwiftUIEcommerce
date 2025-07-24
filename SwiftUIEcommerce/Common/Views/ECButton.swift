//
//  ECButton.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 14.07.2025.
//

import SwiftUI

struct ECTextButton: View {
    let label: String?
    let localizedStringKey: LocalizedStringKey?
    let action: () -> Void
    let maxWidth: CGFloat?
    
    init(label: String, maxWidth: CGFloat? = nil, action: @escaping () -> Void) {
        self.label = label
        self.maxWidth = maxWidth
        self.action = action
        self.localizedStringKey = nil
    }
    
    init(localizedStringKey: LocalizedStringKey, maxWidth: CGFloat? = nil, action: @escaping () -> Void) {
        self.localizedStringKey = localizedStringKey
        self.maxWidth = maxWidth
        self.action = action
        self.label = nil
    }
    
    var body: some View {
        Button(action: action) {
            Group{
                if let label = label {
                    ECText(label: label, foregroundColor: .accentColor, font: .body)
                        .frame(maxWidth: maxWidth)
                }
                else {
                    ECText(localizedStringKey: localizedStringKey!, foregroundColor: .accentColor, font: .body)
                        .frame(maxWidth: maxWidth)
                }
                
                
            }
        }
    }
}

struct ECFilledButton: View {
    let label: String?
    let localizedStringKey: LocalizedStringKey?
    let action: () -> Void
    let maxWidth: CGFloat?
    
    init(label: String, maxWidth: CGFloat? = nil, action: @escaping () -> Void) {
        self.label = label
        self.maxWidth = maxWidth
        self.action = action
        self.localizedStringKey = nil
    }
    
    init(localizedStringKey: LocalizedStringKey, maxWidth: CGFloat? = nil, action: @escaping () -> Void) {
        self.localizedStringKey = localizedStringKey
        self.label = nil
        self.maxWidth = maxWidth
        self.action = action
      
    }

    var body: some View {
        Button(action: action) {
            Group {
                if let label = label {
                    ECText(label: label, foregroundColor: .onAccent, font: .headline)
                }
                else {
                    ECText(localizedStringKey: localizedStringKey!, foregroundColor: .onAccent, font: .headline)
                }
            }
          
                .frame(maxWidth: maxWidth)
                .padding(.vertical, 12)
                .padding(.horizontal, 24)
                .background(Color.accentColor)
                .cornerRadius(12)
        }
    }
}
