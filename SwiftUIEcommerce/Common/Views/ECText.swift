//
//  ECText.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI

struct ECText: View {
    private let label: String?
    private let localizedStringKey: LocalizedStringKey?
    private let foregeroundColor: Color
    private let font: Font?

    init(label: String, foregroundColor: Color = .ecOnBackground, font: Font? = nil) {
        self.label = label
        self.localizedStringKey = nil
        self.foregeroundColor = foregroundColor
        self.font = font
    }

    init(localizedStringKey: LocalizedStringKey, foregroundColor: Color = .ecOnBackground, font: Font? = nil) {
        self.localizedStringKey = localizedStringKey
        self.label = nil
        self.foregeroundColor = foregroundColor
        self.font = font
    }

    var body: some View {
        
        Group {
            if let label = label {
                Text(verbatim: label)
            
            }
            else {
                Text(localizedStringKey!)
            }
        }
        .foregroundColor(foregeroundColor)
        .font(font)
        
        
      
          
    }
}
