//
//  ECScrollView.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 25.07.2025.
//

import SwiftUI

struct ECScrollView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        ScrollView {
            content()
        }
        .background(.ecBackground)
    }
}
