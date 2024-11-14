//
//  WeatherListScreen.swift
//  weatherApp
//
//  Created by Phương An on 07/11/2024.
//

import SwiftUI
import WeatherShared
enum Sheets : Identifiable{
    var id : UUID{
        return UUID()
    }
    case addNewCity
    case settings
}
struct WeatherListScreen: View {
    @EnvironmentObject var store : Store
    @State private var activeSheet : Sheets?
    var body: some View {
        List{
            ForEach(store.weatherList,id : \.id){
                weather in WeatherCell(weather : weather)
            }
        }
        .listStyle(PlainListStyle())
        .sheet(item : $activeSheet , content : {(item) in switch item {
        case .addNewCity:
            AddCityScreen().environmentObject(store)
        case .settings:
            SettingsScreen().environmentObject(store)
        }
        })
        .navigationBarItems(leading : Button(action : {
            activeSheet = .settings
        }) {
            Image(systemName: "gearshape")
        },trailing:Button(action:{activeSheet = .addNewCity},label:{
            Image(systemName: "plus")
        }))
        .navigationTitle("Cities")
        .embedInNavigationView()
        
    }
}

struct WeatherListScreen_Preview: PreviewProvider{
    static var previews : some View{
        return WeatherListScreen() .environmentObject(Store.shared)
    }
}
struct WeatherCell : View{
    let weather :WeatherViewModel
    @EnvironmentObject var store : Store
    var body : some View{
        HStack{
            VStack(alignment : .leading, spacing : 15){
                Text(weather.city)
                    .fontWeight(.bold)
                HStack{
                    Image(systemName: "sunrise")
                    Text("\(weather.sunrise.formatAsString())")

                }
            }
            Spacer()
            URLImage(url : Constants.Urls.weatherURLAsStringByIcon(icon: weather.icon))
                .frame(width : 50,height : 50)
            Text("\(Int(weather.getTemperatureByUnit(unit: store.selectedUnit)))\(String(store.selectedUnit.displayText.prefix(1)))")
        }
        .padding()
        .background(Color(#colorLiteral(red: 0.9133135676, green: 0.9335765243, blue: 0.98070997, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius : 10 , style : .continuous))
    }
}
