//
//  ECText.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI
import ViewConfigurable

@ViewConfigurable
struct ECText: View {
    private let label: String?
    private let localizedStringKey: LocalizedStringKey?
    
    private var viewConfig = ViewConfiguration()
    struct ViewConfiguration {
        var ecTextColor: Color = .ecOnBackground
    }
   
    init(label: String) {
        self.label = label
        self.localizedStringKey = nil
    }

    init(localizedStringKey: LocalizedStringKey) {
        self.localizedStringKey = localizedStringKey
        self.label = nil
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
        .foregroundColor(viewConfig.ecTextColor)
    }
}
