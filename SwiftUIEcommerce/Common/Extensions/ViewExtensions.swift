//
//  ViewExtensions.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 17.07.2025.
//

import SwiftUI

extension View {
    func taskOnce(priority: TaskPriority = .userInitiated, _ action: @escaping @Sendable () async -> Void) -> some View {
        modifier(TaskOnceModifier(priority: priority, action: action))
    }
}
