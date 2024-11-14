//
//  URLImage.swift
//  weatherApp
//
//  Created by Phương An on 08/11/2024.
//
import SwiftUI
import Foundation

public struct URLImage: View {
    public let url: String
    public let placeholder: String
    @ObservedObject var imageLoader = ImageLoader()

    public init(url: String, placeholder: String = "cloud") {
        self.url = url
        self.placeholder = placeholder
        self.imageLoader.downloadImage(url: self.url)
    }

    public var body: some View {
        if let data = self.imageLoader.downloadedData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image(systemName: placeholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    self.imageLoader.downloadImage(url: self.url)
                }
        }
    }
}
