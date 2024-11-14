//
//  ImageLoader.swift
//  weatherApp
//
//  Created by Phương An on 08/11/2024.
//
import Foundation
// ImageLoader class to handle downloading images
public class ImageLoader: ObservableObject {
    @Published var downloadedData: Data?

    public func downloadImage(url: String) {
        guard let imageURL = URL(string: url) else {
            print("Invalid URL: \(url)")
            return
        }

        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                self.downloadedData = data
            }
        }.resume()
    }
}
