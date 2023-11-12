//
//  Account.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation

public enum Currency: String {
    case inr = "INR"
    case usd = "USD"
}

public typealias Accounts = [Account]

public struct Account {
    var id = UUID()
    let balance: Double?
    let title: String?
    let currency: Currency?
    let notes: String?
    let transactions: Transactions
    
    public init(id: UUID = UUID(), balance: Double?, 
                title: String?, currency: Currency?,
                notes: String? = "", transactions: Transactions = []) {
        self.id = id
        self.balance = balance
        self.title = title
        self.currency = currency
        self.notes = notes
        self.transactions = transactions
    }
    
    public init(balance: Double? = 0.0, title: String?, notes: String? = "", transactions: Transactions = []) {
        self.id = UUID()
        self.balance = balance
        self.title = title
        self.currency = .inr
        self.notes = notes
        self.transactions = transactions
    }
}
