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
            Group {
                if let label = label {
                    ECText(label: label, foregroundColor: .ecAccent, font: .body)
                        .frame(maxWidth: maxWidth)
                }
                else {
                    ECText(localizedStringKey: localizedStringKey!, foregroundColor: .ecAccent, font: .body)
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
    let disabled: Bool

    init(label: String, maxWidth: CGFloat? = nil, disabled: Bool = false, action: @escaping () -> Void) {
        self.label = label
        self.maxWidth = maxWidth
        self.action = action
        self.localizedStringKey = nil
        self.disabled = disabled
    }

    init(localizedStringKey: LocalizedStringKey, maxWidth: CGFloat? = nil, disabled: Bool = false, action: @escaping () -> Void) {
        self.localizedStringKey = localizedStringKey
        self.label = nil
        self.maxWidth = maxWidth
        self.action = action
        self.disabled = disabled
    }

    var body: some View {
        Button(action: action) {
            Group {
                if let label = label {
                    ECText(label: label, foregroundColor: .ecOnAccent, font: .headline)
                }
                else {
                    ECText(localizedStringKey: localizedStringKey!, foregroundColor: .ecOnAccent, font: .headline)
                }
            }

            .frame(maxWidth: maxWidth)
            .padding(.vertical, 12)
            .padding(.horizontal, 24)
            .conditionalBackground(.ecAccent, if: !disabled)
        
            .cornerRadius(12)
        }    
        .disabled(disabled)
    }
}

struct ECIconButton: View {
    let iconName: String
    let action: () -> Void
    let size: CGFloat
    let disabled: Bool

    init(iconName: String, size: CGFloat = 20, disabled: Bool = false, action: @escaping () -> Void) {
        self.iconName = iconName
        self.size = size
        self.action = action
        self.disabled = disabled
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .foregroundColor(.ecOnAccent)
                .padding(8)
                .conditionalBackground(.ecAccent, if: !disabled)
                .clipShape(Circle())
        }
    
        .disabled(disabled)
    }
}

private extension View {
    @ViewBuilder
      func conditionalBackground(_ color: Color, if condition: Bool) -> some View {
          if condition {
              self.background(color)
          } else {
              self.background(.gray.opacity(0.45))
          }
      }
}
