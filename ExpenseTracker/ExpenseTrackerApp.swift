//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {

    var body: some Scene {
        WindowGroup {
            if JailBreakCheck.checkForJailBreakDevice() {
                exit(-1)
            }
            TabsView()
        }
    }
}
