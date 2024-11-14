//
//  AddCityScreen.swift
//  weatherApp
//
//  Created by Phương An on 08/11/2024.
//

import SwiftUI
import WeatherShared
import WidgetKit

struct AddCityScreen: View {
    @EnvironmentObject var store: Store
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var addWeatherVM = AddWeatherViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                TextField("Enter City", text: $addWeatherVM.city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Save") {
                    addWeatherVM.save { weather in
                        // Save weather in environment object
                        store.addWeather(weather)
                        
                        // Add city to UserDefaults
                        addCityToUserDefaults(addWeatherVM.city)
                        
                        // Dismiss view
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding(10)
                .frame(maxWidth: UIScreen.main.bounds.width / 4)
                .foregroundColor(.white)
                .background(Color(#colorLiteral(red: 0.1297150552, green: 0.3200980425, blue: 0.8191890121, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(Color(#colorLiteral(red: 0.913837254, green: 0.9333122373, blue: 0.9802277684, alpha: 1)))
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            
            Spacer()
        }
        .padding()
        .navigationTitle("Add City")
        .embedInNavigationView()
    }
    
    // Function to add city to UserDefaults
    public func addCityToUserDefaults(_ city: String) {
        let userDefaults = UserDefaults(suiteName: "group.Weboo")
        var cities = userDefaults?.array(forKey: "lastAddedCities") as? [String] ?? []
        
        if !cities.contains(city) {
            cities.append(city)
            userDefaults?.set(cities, forKey: "lastAddedCities")
            // Request widget update
            WidgetCenter.shared.reloadAllTimelines()
        }
    }

}

struct AddCityScreen_Preview: PreviewProvider {
    static var previews: some View {
        AddCityScreen().environmentObject(Store.shared)
    }
}
