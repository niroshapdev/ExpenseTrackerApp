//
//  TransactionService.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import Foundation

enum TransactionServiceErrors: String, Error {
    case noRecord = "Could not find the transaction"
    case addEdit = "Could not save the transaction"
    case fetch = "Could not fetch the transaction"
    case update = "Could not find the transaction to update"
    case delete = "Could not find the transaction to delete"
}

public protocol TransactionService {
    func addTransaction(transaction: Transaction) throws
    func fetchTransactions() throws -> Transactions
    func editTransaction(transaction: Transaction) throws
    func deleteTransaction(transaction: Transaction) throws
    func fetchTransactions(for account: Account) throws -> Transactions
}
