//
//  ContentView.swift
//  weatherApp
//
//  Created by Phương An on 07/11/2024.
//

import Foundation

public struct WeatherResponse: Decodable {
    public let name: String           // City name
    public let main: Main              // Main weather data, including temperature
    public let weather: [WeatherIcon]  // Array of weather conditions (usually contains one item)
    public let sys: Sys                // Sunrise and sunset times

    // `main` struct captures temperature
    public struct Main: Decodable {
        public let temp: Double
    }

    // `WeatherIcon` captures the weather icon data
    public struct WeatherIcon: Decodable {
        public let main: String
        public let description: String
        public let icon: String
    }

    // `Sys` struct captures sunrise and sunset times, converted to `Date`
    public struct Sys: Decodable {
        public let sunrise: Date
        public let sunset: Date
        
        public enum CodingKeys: String, CodingKey {
            case sunrise
            case sunset
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let sunriseTimeInterval = try container.decode(TimeInterval.self, forKey: .sunrise)
            let sunsetTimeInterval = try container.decode(TimeInterval.self, forKey: .sunset)
            
            sunrise = Date(timeIntervalSince1970: sunriseTimeInterval)
            sunset = Date(timeIntervalSince1970: sunsetTimeInterval)
        }
    }
}
public struct Weather {
    public let city: String
    public let temperature: Double
    public let icon: String
    public let sunrise: Date
    public let sunset: Date
    
    public init(city: String, temperature: Double, icon: String, sunrise: Date, sunset: Date) {
        self.city = city
        self.temperature = temperature
        self.icon = icon
        self.sunrise = sunrise
        self.sunset = sunset
    }
    
    // Convenience initializer to create `Weather` from `WeatherResponse`
    public init(from response: WeatherResponse) {
        self.city = response.name
        self.temperature = response.main.temp
        self.icon = response.weather.first?.icon ?? ""
        self.sunrise = response.sys.sunrise
        self.sunset = response.sys.sunset
    }
}
