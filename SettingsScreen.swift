//
//  SettingsScreen.swift
//  weatherApp
//
//  Created by Phương An on 08/11/2024.
//

import Foundation
import SwiftUI

// Make the TemperatureUnit enum public
public enum TemperatureUnit: String, CaseIterable, Identifiable {
    public var id: String {
        return rawValue
    }
    case celsius
    case fahrenheit
    case kelvin
    
    // Make the displayText accessible outside by marking it as public
    public var displayText: String {
        switch self {
        case .celsius:
            return "Celsius"
        case .fahrenheit:
            return "Fahrenheit"
        case .kelvin:
            return "Kelvin"
        }
    }
}

// Make the SettingsScreen struct public
public struct SettingsScreen: View {
    @EnvironmentObject public var store: Store
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @AppStorage("unit") private var selectedUnit: TemperatureUnit = .kelvin
    
    public init() {} // Add a public initializer to make this accessible

    public var body: some View {
        VStack {
            Picker(selection: $selectedUnit, label: Text("Select temperature unit?")) {
                ForEach(TemperatureUnit.allCases, id: \.self) {
                    Text($0.displayText)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Spacer()
        }
        .padding()
        .navigationTitle("Settings")
        .navigationBarItems(trailing: Button("Done") {
            mode.wrappedValue.dismiss()
            store.selectedUnit = selectedUnit
        })
        .embedInNavigationView()
    }
}

// Make the preview struct public as well
public struct SettingsScreen_Preview: PreviewProvider {
    public static var previews: some View {
        SettingsScreen().environmentObject(Store.shared)
    }
}
