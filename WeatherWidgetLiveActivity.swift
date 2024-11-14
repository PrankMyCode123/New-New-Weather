//
//  WeatherWidgetLiveActivity.swift
//  WeatherWidget
//
//  Created by Phương An on 13/11/2024.
//

import Foundation
import ActivityKit

struct WeatherWidgetLiveActivity: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Define any state information needed for the Live Activity
        var temperature: Double
        var city: String
    }

    // Static properties that define the context of the Live Activity
    var city: String
}
