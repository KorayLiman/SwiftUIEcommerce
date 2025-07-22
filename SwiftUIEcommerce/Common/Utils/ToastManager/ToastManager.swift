//
//  ToastManager.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 17.07.2025.
//

import Observation
import SwiftUI

@Observable
final class ToastManager {
    private(set) var activeToast: ECToast?
    @ObservationIgnored private var workItem: DispatchWorkItem?

    func showToast(_ toast: ECToast) {
        if activeToast != nil { return }

        withAnimation(.easeInOut(duration: 0.3)) {
            activeToast = toast
        }

        UIImpactFeedbackGenerator(style: .light)
            .impactOccurred()

        workItem = DispatchWorkItem {
            guard self.activeToast != nil else { return }
            self.activeToast = nil
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + activeToast!.duration, execute: workItem!)
    }

    func hideToast() {
        guard activeToast != nil else { return }
        activeToast = nil
        workItem?.cancel()
    }

    var getActiveToast: ECToast? {
        return activeToast
    }
}
