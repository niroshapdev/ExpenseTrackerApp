//
//  StringConstants.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation
import SwiftUI

public enum DefaultConstants {
    public static let defaultAccount = Account(balance: 0.0, title: "",
                                               currency: .inr, notes: "")
    public static let defaultCategory = Category(title: "",
                                                 color: "Red",
                                                 icon: IconConstants.plus,
                                                 type: .income,
                                                 date: Utils.formatDate(date: .now)
    )
    public static let defaultColor = Color.blue
    public static let colorString = "#0000FF"
}

public enum StringConstants {
    static let title = "Title"
    
    public enum AppConstants {
        public static let inrCurrency = "INR"
        public static let currencies = ["USD", "EUR", "GBP", "JPY", "CAD", "AUD", "CNY", "INR", "MXN", "BRL"]
        public static let categoryIcons =
        ["circle.hexagongrid.circle", "bookmark.circle", "sunrise.circle",
         "smoke.circle", "mic.circle", "bolt.circle", "handbag.circle",
         "fuelpump.circle", "dog.circle", "tree.circle", "tshirt.circle",
         "hourglass.circle", "soccerball.circle.inverse", "snowflake.circle",
         "tag.circle", "bag.circle", "dollarsign.circle",
         "arrow.triangle.2.circlepath.circle", "gift.circle",
         "person.circle", "popcorn.circle", "graduationcap.circle",
         "cart.circle", "car.circle",  "fork.knife.circle",
         "house.circle", "staroflife.circle", "storefront.circle",
         "washer.circle", "drop.circle", "video.circle",
         "headphones.circle", "pill.circle"]
    }
    
    public enum GoalConstants {
        public static let enterGoal = "Enter your goal"
        public static let goalText = "Goals are a simple way to achieve your personal finance goal such as paying off a loan, saving for a vacation, etc."
        public static let addGoal = "Add goal"
        public static let editGoal = "Edit goal"
        public static let goals = "Goals"
        public static let viewGoals = "View Goals"
        public static let add = "Add"
        public static let targetAmount = "Target Amount"
        public static let savedAmount = "Saved Amount"
    }
    
    public enum TodayViewConstants {
        public static let screenTitle = "Today"
        public static let selectIcon = "Select an Icon"
        public static let expense = "Expense"
        public static let income = "Income"
        public static let newCategory = "New Category"
        public static let categoryType = "Category Type"
        public static let save = "Save"
        
    }
    
    public enum BalancesConstants {
        public static let balancesTab = "Balances"
        public static let errorText =
        "There are no accounts to display to fetch balances, please add your accounts by clicking on Add button on top"
    }
    
    public enum ReportsConstants {
        public static let reports = "Reports"
        public static let errorText = "There are no reports to display"
        public static let totalExpenses = "Total Expenses"
        public static let totalIncome = "Total Income"
        public static let income = "Income"
        public static let expenses = "Expenses"
    }
    public enum SettingsConstants {
        public static let screenTitle = "Settings"
        public static let addCategory =  "Add Category"
        public static let viewCategories = "View Categories"
        public static let plus = "plus"
        public static let developerMode = "Developer Mode"
        public static let views = "Views"
        public static let components = "Components"
        public static let progressView = "ProgressView"
        public static let buttonsView = "Buttons View"
        public static let floatingTextField = "Floating label text field"
        public static let pieChart = "Pie chart"
    }
    
    public enum AccountConstants {
        public static let accounts = "Accounts"
        public static let currency = "Currency"
        public static let balance = "Balance"
        public static let notes = "Notes"
        public static let paymentAccounts = "Payment Accounts"
        public static let addAccount = "Add Account"
        public static let selectAccount = "Select Account"
        public static let add = "Add"
        public static let edit = "Edit"
        public static let done = "Done"
        public static let noAccounts = "There are no accounts to select, please add accounts by clicking on Add button"
        public static let viewAccounts = "View Accounts"
        public static let totalBalance =  "Total Balance:"
        public static let openingBalance =  "Opening Balance:"
    }
    public enum CategoryConstants {
        public static let noCategory = "No Category"
        public static let delete = "Delete"
    }
    public enum TransactionConstants {
        public static let noTransactions = "There are no transactions to display, please add transactions by clicking on Add button"
        public static let plannedTransactions = "Planned Transactions"
        public static let paidTransactions = "Paid Transactions"
        public static let transactions = "Transactions"
        public static let addTransaction = "Add Transaction"
        public static let editTransaction = "Edit Transaction"
        public static let viewTransactions = "View Transactions"
        public static let amount = "Amount:"
        public static let type = "Type"
        public static let notes = "Notes"
        public static let date = "Date"
        public static let selectAccount = "Account"
        public static let selectCategory = "Category"
        public static let transactionType = "Transaction Type"
    }
    
    public enum HomeViewConstants {
        public static let settingsTab = "Settings"
        public static let todayTab = "Today"
        public static let expensesTab = "Expenses"
    }
    
    public enum ErrorConstants {
        public static let noCategories = "No categories available. Add a Category in Settings to start recording expenses"
        public static let fetchCategories = "Unable to fetch categories"
        public static let deleteCategories = "Unable to delete a category"
        public static let editCategories = "Unable to edit/update category"
        public static let addCategories = "Unable to add categories"
        public static let noTransactions =
        "No transactions available. \n Add a Transaction in Settings to start recording expenses"
        public static let fetchTransactions = "Unable to fetch transactions"
        public static let deleteTransactions = "Unable to delete a transaction"
        public static let editTransactions = "Unable to edit/update transaction"
        public static let addTransactions = "Unable to add transactions"
        
        public static let noAccounts = "No accounts available. Add an account in Settings to start recording expenses"
        public static let fetchAccounts = "Unable to fetch account"
        public static let deleteAccounts = "Unable to delete a account"
        public static let editAccounts = "Unable to edit/update account"
        public static let addAccounts = "Unable to add account"
        
        public static let noGoals = "No Goals available. Add a goal in Settings to start recording Goals"
        public static let fetchGoals = "Unable to fetch Goals"
        public static let deleteGoals = "Unable to delete a goal"
        public static let editGoals = "Unable to edit/update goal"
        public static let addGoals = "Unable to add goal"
    }
}
