//
//  IconConstants.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import SwiftUI

// This is created to maintain icon constants
struct IconConstants {
    static let calendar = "calendar"
    static let tray = "tray"
    static let chart = "chart.pie.fill"
    static let gear = "gear"
    static let plus = "plus.circle"
    static let goal = "square.and.pencil"
    static let menucard = "menucard"
    static let chevronRight = "chevron.right"
    static let chevronDown = "chevron.down"
    static let filter = "line.3.horizontal.decrease.circle.fill"
    static let trash = "trash"
}

struct Icons {
   static var goalImage: some View {
        Image(systemName: IconConstants.goal)
            .resizable()
            .foregroundColor(ColorConstants.purpleColor)
            .frame(width: 50, height: 50)
    }
    
    static var plusImage: some View {
        Image(systemName: IconConstants.plus)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 50, height: 50)
            .foregroundColor(ColorConstants.purpleColor)
            .padding()
    }
    
    static var calendarImage: some View {
        Image(systemName: IconConstants.calendar)
            .foregroundColor(ColorConstants.purpleColor)
            .padding()
    }
}
