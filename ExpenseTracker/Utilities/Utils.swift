//
//  Utils.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import Foundation
import SwiftUI

public struct Utils {
    static let dateFormatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()
    
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.isLenient = true
        formatter.numberStyle = .currency
        return formatter
    }()
    
    static func dateToStringWithTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy hh:mm a"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    static func dateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    static func stringToDate(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy hh:mma"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            Logger.log("Invalid date format", level: .error)
            return Date.now
        }
    }
    
    static func getDay() -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: Date())
    }
    
    static func getMonth() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthName = dateFormatter.string(from: currentDate)
        return monthName
    }
    
    static  func getYear() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy" 
        let formattedYear = dateFormatter.string(from: currentDate)
        return formattedYear
    }
    
    static func getDayName() -> String {
        let currentDate = Date()
        let dayOfWeek = Calendar.current.component(.weekday, from: currentDate)
        let dayName = Calendar.current.weekdaySymbols[dayOfWeek - 1]
        return dayName
    }
}

extension Utils {
    static func getFormattedAmount(transactionType: TransactionType, amount: Double) -> some View {
        let formattedAmount: String
        
        if amount < 0 || transactionType == .debit {
            // If amount is negative, format it as -amount and return in red color
            formattedAmount = String(format: "-%.2f", amount)
            return   Text(formattedAmount)
                .foregroundColor(.red)
                .fontWeight(.semibold)
        } else {
            // If amount is positive, format it as +amount and return in green color
            formattedAmount = String(format: "+%.2f", amount)
            return Text(formattedAmount)
                .foregroundColor(.green)
                .fontWeight(.semibold)
        }
    }
    
   static func colorFromHex(_ hex: String) -> Color? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        return Color(
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0,
            opacity: 1.0
        )
    }
}

public extension Utils {
    static func formatDate(date: Date) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy hh:mm:ss"
        let formattedDateString = dateFormatter.string(from: date)
        guard let formattedDate = dateFormatter.date(from: formattedDateString) else {
            return .now
        }
        return formattedDate
    }
}

struct AppConfiguration {
#if DEBUG
    static let isDeveloperModeEnabled = true
#else
    static let isDeveloperModeEnabled = false
#endif
}
