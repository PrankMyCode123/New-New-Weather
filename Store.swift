//
//  Store.swift
//  weatherApp
//
//  Created by Đinh Trung Quốc Anh on 9/11/24.
//
import Foundation
import Combine

public class Store: ObservableObject {
    public static let shared = Store() // Singleton instance

    @Published public var selectedUnit: TemperatureUnit = .kelvin
    @Published public var weatherList: [WeatherViewModel] = []
    @Published public var lastCity: String?

    // Change this initializer's protection level
    public init() { // Made public so it can be accessed from other modules
        selectedUnit = UserDefaults.standard.unit
    }
    
    public func addWeather(_ weather: WeatherViewModel) {
        weatherList.append(weather)
        lastCity = weather.city
    }
}
