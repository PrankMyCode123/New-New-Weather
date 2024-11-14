//
//  WeatherViewModel.swift
//  weatherApp
//
//  Created by Đinh Trung Quốc Anh on 9/11/24.
//

import Foundation

public struct WeatherViewModel {
    
    public let weather: Weather    
    public let id = UUID()
    public init(weather: Weather) {
        self.weather = weather
    }
    
     public func getTemperatureByUnit(unit: TemperatureUnit) -> Double {
        switch unit {
            case .kelvin:
                return weather.temperature
            case .celsius:
                return weather.temperature - 273.15
            case .fahrenheit:
                return 1.8 * (weather.temperature - 273) + 32
        }
    }
    
   public var temperature: Double {
        return weather.temperature
    }
    
   public var city: String {
        return weather.city
    }
    
 public var icon: String {
        return weather.icon
    }
    
  public var sunrise: Date {
        return weather.sunrise
    }
    
  public var sunset: Date {
        return weather.sunset
    }
    
    
}
