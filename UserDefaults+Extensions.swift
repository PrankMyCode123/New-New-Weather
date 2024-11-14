//
//  UserDefaults+Extensions.swift
//  weatherApp
//
//  Created by Phương An on 08/11/2024.
//

import WidgetKit

public extension UserDefaults {
    static var shared: UserDefaults? {
        return UserDefaults(suiteName: "group.Weboo")
    }
    
    var unit: TemperatureUnit {
        guard let value = UserDefaults.shared?.value(forKey: "unit") as? String else {
            return .kelvin
        }
        return TemperatureUnit(rawValue: value) ?? .kelvin
    }

    var lastAddedCities: [String] {
        get {
            return UserDefaults.shared?.array(forKey: "lastAddedCities") as? [String] ?? ["Ho Chi Minh"]
        }
        set {
            UserDefaults.shared?.set(newValue, forKey: "lastAddedCities")
            
            // Request a widget update after setting the new value
            WidgetCenter.shared.reloadAllTimelines()
        }
    }
}
