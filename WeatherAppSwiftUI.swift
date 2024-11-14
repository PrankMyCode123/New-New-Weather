//
//  WeatherAppSwiftUI.swift
//  midApp
//
//  Created by Phương An on 11/11/2024.
//

import Foundation
import SwiftUI
import WeatherShared
@main
struct WeatherAppSwiftUI: App {
    var body: some Scene {
        WindowGroup {
            WeatherListScreen()
                .environmentObject(Store.shared) // Use the singleton instance
        }
    }
}
