//
//  TestData.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 27/10/23.
//

import Foundation
import SwiftUI

private enum TestDataConstants {
    enum AccountsConstants {
        static let hdfcSavingsAccountUUID = "c5439c45-7b65-4055-88cf-962c81a6cd57"
        static let hdfcCurrentAccountUUID = "2d14431d-283d-43a3-b2c6-e0e3ebee614d"
        static let sbiSavingsAccountUUID = "ac0c7049-77e0-470a-a87d-0f0742ae9861"
        static let iciciBankSavingsAccountUUID = "3b7784c8-a2ed-44dc-a9e0-d688e6e655c1"
        static let paytmWalletUUID = "9abfc4dc-696f-49c0-97b1-4e3dac9a927a"
        static let paytmBankUUID = "61fb708e-64f5-4c22-bff6-78dac6ef5d7e"
    }
    
    enum CategoriesConstants {
        static let car = "55bd7af2-fda6-4e13-9b98-4ba5f11bfca1"
        static let dining = "b9f40703-eff7-4101-80d6-dec729a3d62e"
        static let water = "74578671-4c8d-4e5c-b0ac-94ab01315668"
        static let groceries = "9a967dd6-2aec-4b67-89d7-47ad8bad645f"
        static let education = "054c3864-2085-428b-af66-1559809b0af9"
        static let home = "bc8afcb1-f021-4f24-8d0c-dcff3c623e90"
        static let health = "0f863e7e-afee-4c00-9025-0431eaf87563"
        static let transport = "ebb0dea4-f9dd-4448-a9db-46c7a41cb141"
        static let shopping = "b96e1884-5699-4302-999a-80f27c90b61e"
        static let utilities = "d6abe4a0-4311-4084-8fed-eded5da18a47"
        static let other = "766402e1-47e2-42a9-9186-87c5931bd665"
        static let salary = "87AF5680-067C-4B69-8DD6-33F1F4ECC584"
        static let gifts = "E621E1F8-C36C-495A-93FC-0C247A3E6E5F"
        static let interest = "DFFC75B4-C92F-4DA9-97CA-7F0EEF067FF2"
        static let dividendIncome = "DF92B4B0-F5EE-42E5-9577-A9FC373C71A4"
        static let businessincome = "A453FB62-DF71-436F-9AC1-0414793DFA16"
    }
}

struct TestData {
    
    static let categories = [
        Category(id: TestDataConstants.CategoriesConstants.car.toUUID(),
                 title: "Car", color: Color.random().toString(), icon: "car.circle", 
                 type: .expense, date: Utils.stringToDate("10-Nov-2023 7:00PM")),
        Category(id: TestDataConstants.CategoriesConstants.dining.toUUID(),
                 title: "Dining", color: Color.random().toString(), icon: "fork.knife.circle", 
                 type: .expense, date: Utils.stringToDate("10-Nov-2023 7:01PM")),
        Category(id: TestDataConstants.CategoriesConstants.home.toUUID(),
                 title: "Home", color: Color.random().toString(), icon: "house.circle", 
                 type: .expense, date: Utils.stringToDate("10-Nov-2023 7:02PM")),
        Category(id: TestDataConstants.CategoriesConstants.health.toUUID(),
                 title: "Health", color: Color.random().toString(), icon: "staroflife.circle", 
                 type: .expense, date: Utils.stringToDate("10-Nov-2023 7:03PM")),
        Category(id: TestDataConstants.CategoriesConstants.shopping.toUUID(),
                 title: "Shopping", color: Color.random().toString(), icon: "cart.circle", 
                 type: .expense, date: Utils.stringToDate("10-Nov-2023 7:04PM")),
        Category(id: TestDataConstants.CategoriesConstants.transport.toUUID(),
                 title: "Transport", color: Color.random().toString(), icon: "storefront.circle", 
                 type: .expense, date: Utils.stringToDate("10-Nov-2023 7:05PM")),
        Category(id: TestDataConstants.CategoriesConstants.utilities.toUUID(),
                 title: "Utilities", color: Color.random().toString(), icon: "bolt.circle", 
                 type: .expense, date: Utils.stringToDate("10-Nov-2023 7:06PM")),
        Category(id: TestDataConstants.CategoriesConstants.water.toUUID(),
                 title: "Water", color: Color.random().toString(), icon: "drop.circle",
                 type: .expense, date: Utils.stringToDate("10-Nov-2023 7:07PM")),
        Category(id: TestDataConstants.CategoriesConstants.groceries.toUUID(),
                 title: "Groceries", color: Color.random().toString(), icon: "cart.circle", 
                 type: .expense, date: Utils.stringToDate("10-Nov-2023 7:08PM")),
        Category(id: TestDataConstants.CategoriesConstants.education.toUUID(),
                 title: "Education", color: Color.random().toString(), icon: "graduationcap.circle", 
                 type: .expense, date: Utils.stringToDate("10-Nov-2023 7:09PM")),
        Category(id: TestDataConstants.CategoriesConstants.other.toUUID(),
                 title: "Others", color: Color.random().toString(), icon: "tag.circle", 
                 type: .expense, date: Utils.stringToDate("10-Nov-2023 7:10PM")),
        Category(id: TestDataConstants.CategoriesConstants.salary.toUUID(),
                 title: "Salary", color: Color.random().toString(), icon: "person.circle", 
                 type: .income, date: Utils.stringToDate("10-Nov-2023 7:11PM")),
        Category(id: TestDataConstants.CategoriesConstants.gifts.toUUID(),
                 title: "Gifts", color: Color.random().toString(), icon: "gift.circle", 
                 type: .income, date: Utils.stringToDate("10-Nov-2023 7:12PM")),
        Category(id: TestDataConstants.CategoriesConstants.interest.toUUID(),
                 title: "Interest", color: Color.random().toString(),
                 icon: "arrow.triangle.2.circlepath.circle", type: .income, 
                 date: Utils.stringToDate("10-Nov-2023 7:13PM")),
        Category(id: TestDataConstants.CategoriesConstants.dividendIncome.toUUID(),
                 title: "Dividend Income", color: Color.random().toString(),
                 icon: "dollarsign.circle", type: .income, date: Utils.stringToDate("10-Nov-2023 7:14PM")),
        Category(id: TestDataConstants.CategoriesConstants.businessincome.toUUID(),
                 title: "Business Income", color: Color.random().toString(),
                 icon: "bag.circle", type: .income, date: Utils.stringToDate("10-Nov-2023 7:15PM")),
        Category(id: TestDataConstants.CategoriesConstants.other.toUUID(),
                 title: "Others", color: Color.random().toString(),
                 icon: "tag.circle", type: .income, date: Utils.stringToDate("10-Nov-2023 7:16PM"))
    ]
    
    static let accounts = [
        Account(id: TestDataConstants.AccountsConstants.hdfcSavingsAccountUUID.toUUID(),
                balance: 10000.0, title: "Savings", currency: .inr, notes: "Savings account")
    ]
    
    static let goals = [
        Goal(title: "School Fee", targetAmount: 100000,
             savedAmount: 20000, currency: StringConstants.AppConstants.inrCurrency),
        Goal(title: "Car", targetAmount: 2500000,
             savedAmount: 90000, currency: StringConstants.AppConstants.inrCurrency),
        Goal(title: "Retirement", targetAmount: 10000000, savedAmount: 20000, 
             currency: StringConstants.AppConstants.inrCurrency),
        Goal(title: "Home", targetAmount: 1200000, savedAmount: 0.0, currency: StringConstants.AppConstants.inrCurrency)
    ]
    
    static let transactions = [
        Transaction(type: .debit,
                    account: accounts[0],
                    category: categories[0],
                    amount: 400,
                    date: Utils.stringToDate("10-Nov-2023 7:00PM"),
                    status: .paid,
                    notes: "Milk",
                    updatedBalance: "30300"),
        Transaction(type: .credit,
                    account: accounts[0],
                    category: categories[5],
                    amount: 10000,
                    date: Utils.stringToDate("10-Nov-2023 8:00AM"),
                    status: .overdue,
                    notes: "Shopping",
                    updatedBalance: "30700"),
        Transaction(type: .debit,
                    account: accounts[0],
                    category: categories[2],
                    amount: 500,
                    date: Utils.stringToDate("26-Oct-2023 9:00PM"),
                    status: .paid,
                    notes: "Groceries",
                    updatedBalance: "20700"),
        Transaction(type: .debit,
                    account: accounts[0],
                    category: categories[7],
                    amount: 3500,
                    date: Utils.stringToDate("25-Oct-2023 7:00PM"),
                    status: .paid,
                    notes: "Milk",
                    updatedBalance: "21200"),
        Transaction(type: .debit,
                    account: accounts[0],
                    category: categories[9],
                    amount: 1000,
                    date: Utils.stringToDate("5-Sep-2023 11:00AM"),
                    status: .paid,
                    notes: "Dance",
                    updatedBalance: "24700"),
        Transaction(type: .credit,
                    account: accounts[0],
                    category: categories[4],
                    amount: 5000,
                    date: Utils.stringToDate("11-Aug-2023 10:00AM"),
                    status: .paid,
                    notes: "Education",
                    updatedBalance: "25700"),
        Transaction(type: .debit,
                    account: accounts[0],
                    category: categories[6],
                    amount: 300,
                    date: Utils.stringToDate("10-Feb-2023 7:00PM"),
                    status: .paid,
                    notes: "Milk",
                    updatedBalance: "20700"),
        Transaction(type: .credit,
                    account: accounts[0],
                    category: categories[3],
                    amount: 5000,
                    date: Utils.stringToDate("2-Jan-2023 8:00AM"),
                    status: .overdue,
                    notes: "Shopping",
                    updatedBalance: "21000"),
        Transaction(type: .credit,
                    account: accounts[0],
                    category: categories[14],
                    amount: 1000,
                    date: Utils.stringToDate("13-July-2023 9:00AM"),
                    status: .paid,
                    notes: "Groceries",
                    updatedBalance: "16000"),
        Transaction(type: .debit,
                    account: accounts[0],
                    category: categories[7],
                    amount: 5000,
                    date: Utils.stringToDate("27-Aug-2022 8:00PM"),
                    status: .paid,
                    notes: "Salary",
                    updatedBalance: "15000"),
        Transaction(type: .credit,
                    account: accounts[0],
                    category: categories[14],
                    amount: 5000,
                    date: Utils.stringToDate("14-Apr-2022 6:00PM"),
                    status: .paid,
                    notes: "Salary",
                    updatedBalance: "20000"),
        Transaction(type: .debit,
                    account: accounts[0],
                    category: categories[2],
                    amount: 5000,
                    date: Utils.stringToDate("27-June-2022 8:00PM"),
                    status: .paid,
                    notes: "House expense",
                    updatedBalance: "15000"),
        Transaction(type: .debit,
                    account: accounts[0],
                    category: categories[1],
                    amount: 5000,
                    date: Utils.stringToDate("27-Feb-2022 8:00PM"),
                    status: .paid,
                    notes: "Salary",
                    updatedBalance: "20000"),
        Transaction(type: .credit,
                    account: accounts[0],
                    category: categories[11],
                    amount: 15000,
                    date: Utils.stringToDate("2-Jan-2022 3:00PM"),
                    status: .paid,
                    notes: "Salary",
                    updatedBalance: "25000")
    ]
}
