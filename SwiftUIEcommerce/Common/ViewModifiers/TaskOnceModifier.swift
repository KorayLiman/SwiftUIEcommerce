//
//  TaskOnceModifier.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 28.07.2025.
//

import SwiftUI

struct TaskOnceModifier: ViewModifier {
    @State private var hasRun = false
    let priority: TaskPriority
    let action: @Sendable () async -> Void
    
    func body(content: Content) -> some View {
        content
            .task(priority: priority) {
                guard !hasRun else { return }
                hasRun = true
                await action()
            }
    }
}
