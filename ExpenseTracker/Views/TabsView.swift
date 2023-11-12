//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import SwiftUI

struct TabsView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
    }
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    VStack {
                        Text(StringConstants.HomeViewConstants.todayTab)
                        Icons.calendarImage
                    }
                }
            BalancesView()
                .tabItem {
                    VStack {
                        Text(StringConstants.BalancesConstants.balancesTab)
                        Image(systemName: IconConstants.tray)
                    }
                }
            ReportsView()
                .tabItem {
                    VStack {
                        Text(StringConstants.ReportsConstants.reports)
                        Image(systemName: IconConstants.chart)
                    }
                }
            // This is to enable developer mode in Debug
            if AppConfiguration.isDeveloperModeEnabled {
                SettingsView()
                    .tabItem {
                        VStack {
                            Text(StringConstants.HomeViewConstants.settingsTab)
                            Image(systemName: IconConstants.gear)
                        }
                    }
            }
            
        } .accentColor(ColorConstants.purpleColor)
    }
}

#Preview {
    TabsView()
}
