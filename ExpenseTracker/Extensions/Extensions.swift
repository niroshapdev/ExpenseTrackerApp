//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import Foundation
import SwiftUI

extension Double {
    var formattedCurrencyText: String {
        return Utils.numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
}

struct RoundedNumberText: View {
    var number: Double
    var decimalPlaces: Int
    
    private var roundedValue: String {
        return String(format: "%.\(decimalPlaces)f", number)
    }
    
    var body: some View {
        Text(roundedValue)
    }
}
extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
    
    func toString() -> String {
        guard let components = UIColor(self).cgColor.components else {
            return ""
        }
        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)
        
        return String(format: "#%02X%02X%02X", red, green, blue)
    }
}

extension String {
    func toDouble() -> Double? {
        Double(self)
    }
    
    func toUUID() -> UUID {
        UUID(uuidString: self) ?? UUID()
    }
}

extension Double {
    func toString() -> String {
        "\(self)"
    }
}
