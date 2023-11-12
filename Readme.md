#  Expense Tracker
<hr>

# About
Expenses Tracker is an iOS application to track personal expenses. 

# Installation & Requirements
Xcode Version: Version 15.0 
Minimum iOS version supported: 12.0

Need to install pod before running the project. Pod file is included in the project just need to do install pod from terminal

Run the following commands on terminal in Projet directory
### Installation of Cocoapods
`sudo gem install cocoapods`

### Installation of dependent libraries
`pod install`

# Dependencies
1. SwiftLint

# Tools 
1. XCode
1. iOS Simulator
1. draw.io - to create flow diagrams
1. Instruments

# Technical aspects
1. Jail broken devices support
1. Unit Testing - Code Coverage
1. Memory Leaks check using Instruments 

# Architecture
1. MVVM 

# App Features
1. Add/Edit/Delete Expense
1. Add/Edit/Delete Categories 
1. Add/Edit/Delete Account
1. Add/Edit/Delete Goals - Future
1. Reports 
1. Show expenses by Month
1. Show expenses by Category
1. Charts
1. Local storage - CoreData 
1. Jailbreak - The app wont launch if its a Jail break device. 

# Reusable components
1. FloatingLabelTextField
1. RoundedTextFieldView
1. CircularProgressView
1. SeparatorView
1. ButtonsView - primary, destructive, custom
1. Pie Chart
1. Color Picker

# Frameworks used
1. SwiftLint 
1. SwiftUI
1. CoreData
1. Foundation

# Developer Mode
It is enabled only in Debug mode, not on the release mode.
In debug mode, developer will be able to perform all these functionalities.
1. Add Category
1. View Categories
1. Add goal
1. View goals
1. Add account
1. View accounts
1. Add transaction
1. View transactions
1. Insert Categories
1. Insert Accounts
1. Insert Goals
1. Insert Transactions
1. It prints SQLite path, where the core data base models are created - Developer can verify the data in the db
1. Lists out all reusable components used in this application
    1. Pie chart
    1. Buttons and available styles
    1. Underline textfield
    1. Progress view

# App Flow 
1. Today Flow
1. Add/Edit/Delete Transaction
1. Add/Edit/Delete Goal
1. Add/Edit/Delete Category
1. Add/Edit/Delete Account
1. Reports
1. Settings (Dev mode only)

# Screenshots
**Today** <BR>
<kbd> <img src="https://github.com/niroshapdev/ExpenseTrackerApp/blob/master/Diagrams/TodayView.png"> </kbd>
<BR>
**Balances** <BR>
<kbd> <img src="https://github.com/niroshapdev/ExpenseTrackerApp/blob/master/Diagrams/BalancesView.png"> </kbd>
<BR>
**Reports** <BR>
<kbd> <img src="https://github.com/niroshapdev/ExpenseTrackerApp/blob/master/Diagrams/ReportsView.png"> </kbd>
<BR>

# Future plans 
1. Notifications 
1. Budget 

# Challenges faced
1. Inserting a new entry with null values (except ID), for each actual entry submitted to CoreData
1. Unable to fetch records while transitioning between views
1. Unable to change background/foreground color for date, while using DatePicker
1. When a new transaction is added, then accounts and categories are creating multiple entries.
1. Unable to fetch records filtering by id. we need to use date as primary key  
1. Editing a transaction.
