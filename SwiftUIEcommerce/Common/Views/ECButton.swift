//
//  ECButton.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 14.07.2025.
//

import SwiftUI
import ViewConfigurable

struct ECTextButton: View {
    let label: String?
    let localizedStringKey: LocalizedStringKey?
    let action: () -> Void

    init(label: String, action: @escaping () -> Void) {
        self.label = label

        self.action = action
        self.localizedStringKey = nil
    }

    init(localizedStringKey: LocalizedStringKey, action: @escaping () -> Void) {
        self.localizedStringKey = localizedStringKey

        self.action = action
        self.label = nil
    }

    var body: some View {
        Button(action: action) {
            Group {
                if let label = label {
                    ECText(label: label)
                        .ecTextColor(.ecAccent)
                        .font(.body)
                }
                else {
                    ECText(localizedStringKey: self.localizedStringKey!)
                        .ecTextColor(.ecAccent)
                        .font(.body)
                }
            }
        }
    }
}

@ViewConfigurable
struct ECFilledButton: View {
    let label: String?
    let localizedStringKey: LocalizedStringKey?
    let action: () -> Void

    init(label: String, action: @escaping () -> Void) {
        self.label = label

        self.action = action
        self.localizedStringKey = nil
    }

    init(localizedStringKey: LocalizedStringKey, action: @escaping () -> Void) {
        self.localizedStringKey = localizedStringKey
        self.label = nil
        self.action = action
    }

    private var viewConfig = ViewConfiguration()

    struct ViewConfiguration {
        var ecDisabled: Bool = false
        var ecMaxWidth: CGFloat? = nil
        var ecMaxHeight: CGFloat? = nil
    }

    var body: some View {
        Button(action: action) {
            Group {
                if let label = label {
                    ECText(label: label)
                        .ecTextColor(.ecOnAccent)
                        .font(.headline)
                }
                else {
                    ECText(localizedStringKey: self.localizedStringKey!)
                        .ecTextColor(.ecOnAccent)
                        .font(.headline)
                }
            }
            .frame(maxWidth: self.viewConfig.ecMaxWidth, maxHeight: self.viewConfig.ecMaxHeight)
            .padding(.vertical, 6)
            .padding(.horizontal, 24)
        }

        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle(radius: 12))
        .disabled(viewConfig.ecDisabled)
    }
}

@ViewConfigurable
struct ECIconButton: View {
    let iconName: String
    let action: () -> Void

    init(iconName: String, action: @escaping () -> Void) {
        self.iconName = iconName
        self.action = action
    }

    private var viewConfig = ViewConfiguration()

    struct ViewConfiguration {
        var ecSize: CGFloat = 20
        var ecDisabled: Bool = false
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: self.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: self.viewConfig.ecSize, height: self.viewConfig.ecSize)
                .foregroundColor(.ecOnAccent)
                .padding(2)
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.circle)
        .disabled(viewConfig.ecDisabled)
    }
}

@ViewConfigurable
struct ECIconButtonRaw: View {
    let iconName: String
    let action: () -> Void

    init(iconName: String, action: @escaping () -> Void) {
        self.iconName = iconName
        self.action = action
    }

    private var viewConfig = ViewConfiguration()

    struct ViewConfiguration {
        var ecSize: CGFloat = 20
        var ecDisabled: Bool = false
    }

    var body: some View {
        Button(action: action) {
            Image(systemName: self.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: viewConfig.ecSize, height: viewConfig.ecSize)
                .foregroundColor(.ecAccent)
        }
        .buttonStyle(.plain)
        .disabled(viewConfig.ecDisabled)
    }
}
