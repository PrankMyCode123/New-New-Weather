//
//  String+Extensions.swift
//  weatherApp
//
//  Created by Phương An on 08/11/2024.
//

import Foundation
extension String{
    func escaped() -> String{
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
}
