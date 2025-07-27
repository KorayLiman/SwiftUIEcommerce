//
//  ECAsyncImage.swift
//  SwiftUIEcommerce
//
//  Created by Koray Liman on 23.07.2025.
//

import SwiftUI

struct ECAsyncImage: View {
    let id: Int

    @State private var image: Image? = nil
    @State private var isLoading = true
    
    private var networkManager: NetworkManager {
        DIContainer.shared.container.resolve(NetworkManager.self)!
    }

    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()

            } else if isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo")
                    .resizable()
            }
        }
        .task {
            let response = await networkManager.request(FileModel.self, path: .file(id: id))
            if let base64ImageString = response.data?.data {
                let data = Data(base64Encoded: base64ImageString)
                if let data = data, let uiImage = UIImage(data: data) {
                    image = Image(uiImage: uiImage)
                }
            }
            isLoading = false
        }
    }
}
