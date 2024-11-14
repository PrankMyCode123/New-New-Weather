//
//  Constant.swift
//  weatherApp
//
//  Created by Phương An on 07/11/2024.
//

import Foundation

public struct Constants {
    public struct Urls {
        public static func weatherByCity(city: String) -> URL? {
            return URL(string:
                        "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=b544b4863ae37d81aab80c727deb5704&units=standards")
        }

        public static func weatherURLAsStringByIcon(icon: String) -> String {
            return "https://openweathermap.org/img/w/\(icon).png"
        }
    }
}
