//
//  AddWeatherViewModel.swift
//  weatherApp
//
//  Created by Đinh Trung Quốc Anh on 9/11/24.
//

import Foundation
import WeatherShared
class AddWeatherViewModel: ObservableObject {
    var city: String = ""
    
    func save(completion: @escaping (WeatherViewModel) -> Void) {
        
        Webservice().getWeatherByCity(city: city) { (result) in
            switch result {
            case.success(let weather):
                DispatchQueue.main.async {
                    completion(WeatherViewModel(weather: weather))
                }
            case.failure(let error):
                print(error)
            }
        }
    }
}
