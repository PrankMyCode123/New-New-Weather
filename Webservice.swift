//
//  Webservice.swift
//  weatherApp
//
//  Created by Phương An on 07/11/2024.
//

import Foundation
import WeatherShared

enum NetworkError: Error {
    case badURL
    case noData
}

class Webservice {
    func getWeatherByCity(city: String, completion: @escaping (Result<Weather, NetworkError>) -> Void) {
        guard let weatherURL = Constants.Urls.weatherByCity(city: city) else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: weatherURL) { (data, _, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                
                // Create a `Weather` object using data from `WeatherResponse`
                if let weatherIcon = weatherResponse.weather.first {
                    let weather = Weather(
                        city: weatherResponse.name,
                        temperature: weatherResponse.main.temp,
                        icon: weatherIcon.icon,
                        sunrise: weatherResponse.sys.sunrise,
                        sunset: weatherResponse.sys.sunset
                    )
                    completion(.success(weather))
                } else {
                    completion(.failure(.noData))
                }
                
            } catch {
                print("Failed to decode JSON: \(error)")
                completion(.failure(.noData))
            }
        }.resume()
    }
}

