//
//  Transaction.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import Foundation

public enum PaymentStatus: String, CaseIterable {
    case paid = "PAID"
    case overdue = "OVERDUE"
    case planned = "PLANNED"
}
public typealias Transactions = [Transaction]

public enum TransactionType: String, CaseIterable {
    case credit = "Credit"
    case debit = "Debit"
}

/// Transaction model
/// Parameters:
/// amount - transaction amount in double format
/// date - transaction date in Date format
/// type - transaction type - Credit or Debit
/// notes - transcation notes - Eg: SIP Debit, Interest Paid

public struct Transaction: Identifiable {
    public var id = UUID()
    let amount: Double?
    let updatedBalance: String?
    let date: Date?
    let type: TransactionType?
    let category: Category?
    let account: Account?
    let notes: String?
    let status: PaymentStatus?
    
    public init(type: TransactionType?, account: Account?, 
                category: Category?, amount: Double?, date: Date?,
                status: PaymentStatus?, notes: String?, updatedBalance: String?) {
        self.type = type
        self.account = account
        self.category = category
        self.amount = amount
        self.date = date
        self.status = status
        self.notes = notes
        self.updatedBalance = updatedBalance
    }
    
//     Default initializer
    public init(id: UUID = UUID(), type: TransactionType = .debit, account: Account?,
                category: Category?, amount: Double? = 0.0, date: Date? = Utils.formatDate(date: .now),
                status: PaymentStatus? = .paid, notes: String? = "", updatedBalance: String? = "") {
        self.id = id
        self.type = type
        self.account = account
        self.category = category
        self.amount = amount
        self.date = date
        self.status = status
        self.notes = notes
        self.updatedBalance = updatedBalance
    }
}
