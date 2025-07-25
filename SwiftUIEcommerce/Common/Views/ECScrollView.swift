//
//  ECScrollView.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 25.07.2025.
//

import SwiftUI

struct ECScrollView<Content>: View where Content: View {
    public var content: Content
    public var axes: Axis.Set
    public var showsIndicators: Bool

    init(_ axes: Axis.Set = .vertical, showsIndicators: Bool = true, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.axes = axes
        self.showsIndicators = showsIndicators
    }

    init(_ axes: Axis.Set = .vertical, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.axes = axes
        self.showsIndicators = true
    }

    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            content
        }
        .background(.ecBackground)
    }
}
