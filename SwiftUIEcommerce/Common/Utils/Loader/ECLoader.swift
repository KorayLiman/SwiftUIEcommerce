//
//  Loader.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 17.07.2025.
//

import Observation
import SwiftUI

@Observable
final class ECLoader {
    @ObservationIgnored private var activeLoaderRequestCount: Int = 0

    private(set) var isLoaderActive = false

    func show() {
        if activeLoaderRequestCount == 0 {
            withAnimation(.linear(duration: 0.15)) {
                isLoaderActive = true
            }
        }

        activeLoaderRequestCount += 1
    }

    func hide() {
        if activeLoaderRequestCount > 0 {
            if activeLoaderRequestCount == 1 {
                withAnimation(.linear(duration: 0.15)) {
                    isLoaderActive = false
                }
            }
            activeLoaderRequestCount -= 1
        }
    }

    var isActive: Bool {
        isLoaderActive
    }
}
