//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by Phương An on 13/11/2024.
//

import SwiftUI
import WidgetKit
import WeatherShared

// Widget configuration
struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WeatherProvider()) { entry in
            WeatherWidgetEntryView(weather: entry.weather, entry: entry)
                .environmentObject(Store.shared)
        }
        .configurationDisplayName("Weather Widget")
        .description("Shows the current weather for a selected city.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// Timeline provider
struct WeatherProvider: TimelineProvider {
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(date: Date(), weather: WeatherViewModel(weather: Weather(city: "Placeholder City", temperature: 298.15, icon: "01d", sunrise: Date(), sunset: Date())))
    }

    func getSnapshot(in context: Context, completion: @escaping (WeatherEntry) -> Void) {
        let entry = WeatherEntry(date: Date(), weather: WeatherViewModel(weather: Weather(city: "Snapshot City", temperature: 298.15, icon: "01d", sunrise: Date(), sunset: Date())))
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WeatherEntry>) -> Void) {
        let cities = UserDefaults(suiteName: "group.Weboo")?.lastAddedCities ?? ["Ho Chi Minh"]
        print("Retrieved cities from User Defaults in Widget:", cities)

        var entries: [WeatherEntry] = []
        let currentDate = Date()
        let dispatchGroup = DispatchGroup()

        for (index, city) in cities.enumerated() {
            dispatchGroup.enter()
            
            WeatherFetcher().fetchWeather(for: city) { weatherViewModel in
                let weatherData = weatherViewModel ?? WeatherViewModel(weather: Weather(city: city, temperature: 0, icon: "01d", sunrise: Date(), sunset: Date()))
                
                let entryDate = currentDate.addingTimeInterval(Double(index) * 5.0) // 5-second interval for each city
                let entry = WeatherEntry(date: entryDate, weather: weatherData)
                entries.append(entry)
                
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            let timeline = Timeline(entries: entries, policy: .after(currentDate.addingTimeInterval(Double(cities.count) * 5.0)))
            completion(timeline)
        }
    }
   
}

// Timeline entry and entry view
struct WeatherEntry: TimelineEntry {
    let date: Date
    let weather: WeatherViewModel
}

struct WeatherWidgetEntryView: View {
    @EnvironmentObject var store: Store
    var weather: WeatherViewModel
    var entry: WeatherProvider.Entry

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(entry.weather.city)
                    .font(.headline)
                    .bold()
                
                HStack {
                    Image(systemName: "sunrise.fill")
                    Text(entry.weather.sunrise.formatAsString())
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                Text("\(Int(weather.getTemperatureByUnit(unit: store.selectedUnit)))\(String(store.selectedUnit.displayText.prefix(1)))")
                    .font(.title)
                    .bold()
            }
            Spacer()
            
            URLImage(url: Constants.Urls.weatherURLAsStringByIcon(icon: entry.weather.icon))
                .frame(width: 50, height: 50)
        }
        .padding()
        .background(Color(red: 149/255, green: 210/255, blue: 255/255))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
