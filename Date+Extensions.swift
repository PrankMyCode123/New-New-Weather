//
//  Date+Extensions.swift
//  weatherApp
//
//  Created by Phương An on 08/11/2024.
//

import Foundation
public extension Date{
        func formatAsString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from:self)
    }
}
