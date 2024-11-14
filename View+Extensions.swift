//
//  View+Extensions.swift
//  weatherApp
//
//  Created by Phương An on 08/11/2024.
//

import Foundation
import SwiftUI
public extension View{
     func embedInNavigationView() -> some View{
        return NavigationView {self}
    }
}
