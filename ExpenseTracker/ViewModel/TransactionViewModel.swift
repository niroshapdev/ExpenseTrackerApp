//
//  AddTransactionViewModel.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import Foundation
import SwiftUI

class TransactionViewModel: ObservableObject {
    var transaction: Transaction?
    let service: TransactionService
    
    @Published var errorText: String = ""
    @Published var hasError: Bool = false
    @Published var balance: Double = 0.0
    init(service: TransactionService = CoreDataTransactionService()) {
        self.service = service
    }
    
    @Published var transactions: Transactions = [] {
        didSet {
            sortedTransactions = transactions.sorted {
                $0.date ?? Utils.formatDate(date: .now) > $1.date ?? Utils.formatDate(date: .now)
            }
        }
    }
    
    @Published var sortedTransactions: Transactions = []
    
    /*
     // =============================== //
     Transaction Type   > Income / Expense
     Select Account     > Accounts list
     Select Category    > Categories List (Income / Expense)
     Amount
     Select Date
     Payment Status     > Paid / Overdue
     Add Notes
     // =============================== //
     */
    func add(
        type: TransactionType,
        account: Account,
        category: Category,
        amount: Double,
        date: Date,
        paymentStatus: PaymentStatus,
        notes: String, updatedBalance: String) {
            let transaction = Transaction(type: type, account: account,
                                          category: category, amount: amount,
                                          date: date, status: paymentStatus,
                                          notes: notes, updatedBalance: updatedBalance)
            add(transaction: transaction)
        }
    
    func add(transaction: Transaction) {
        do {
            try service.addTransaction(transaction: transaction)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.addTransactions
        }
    }
    
    func edit(transaction: Transaction) {
        do {
            try service.editTransaction(transaction: transaction)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.editTransactions
        }
    }
    
    func delete(transaction: Transaction) {
        do {
            try service.deleteTransaction(transaction: transaction)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.deleteTransactions
        }
    }
    
    func fetchTransactions() {
        do {
            transactions = try service.fetchTransactions()
            sortTransactions()
            
            if transactions.count == 0 {
                hasError = true
                errorText = StringConstants.ErrorConstants.noTransactions
            }
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.fetchTransactions
        }
    }
    
    func fetchTransactions(for account: Account) {
        do {
            transactions = try service.fetchTransactions(for: account)
            sortTransactions()
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.fetchTransactions
        }
    }
    
    func getCategoryTitle(transaction: Transaction) -> String {
        if let categoryTitle = transaction.category?.title, !categoryTitle.isEmpty {
            return categoryTitle
        } else {
            return StringConstants.CategoryConstants.noCategory
        }
    }
    func getCategoryIcon(transaction: Transaction) -> String {
        if let categoryIcon = transaction.category?.icon, !categoryIcon.isEmpty {
            return categoryIcon
        } else {
            return IconConstants.plus
        }
    }
    
    private func sortTransactions() {
        transactions.sort {
            $0.date ?? Utils.formatDate(date: .now) > $1.date ?? Utils.formatDate(date: .now)
        }
    }
    
    func filterTransactionsByCustomDate(fromDate: Date, toDate: Date) {
        self.fetchTransactions()
        transactions = transactions.filter { transaction in
            transaction.date ?? Utils.formatDate(date: .now) >= fromDate &&
            transaction.date ?? Utils.formatDate(date: .now) <= toDate
        }
    }
    
    func filterTransactions(for filter: TransactionFilter) {
        self.fetchTransactions()
        let currentDate = Utils.formatDate(date: .now)
        
        switch filter {
        case .last7days:
            if let selectedDate = Calendar.current.date(byAdding: .day,
                                                        value: -7,
                                                        to: currentDate) {
                transactions =
                transactions.filter {
                    $0.date ?? currentDate >= selectedDate
                }
            }
        case .last30days:
            if let selectedDate = Calendar.current.date(byAdding: .day,
                                                        value: -30,
                                                        to: currentDate) {
                transactions =
                transactions.filter {
                    $0.date ?? currentDate >= selectedDate
                }
            }
        case .last90days:
            
            transactions =  transactions.filter {
                $0.date ?? Utils.formatDate(date: .now)
                >= Calendar.current.date(byAdding: .day, value: -90,
                                         to: currentDate) ?? Utils.formatDate(date: .now)
            }
        case .thisMonth:
            transactions = transactions.filter {
                if let transactionDate = $0.date {
                    return Calendar.current.isDate(transactionDate, equalTo: currentDate, toGranularity: .month)
                } else {
                    return false
                }
            }
            
        case .lastMonth:
            let lastMonth = Calendar.current.date(byAdding: .month, value: -1, 
                                                to: currentDate) ?? Utils.formatDate(date: .now)
            transactions = transactions.filter {
                if let transactionDate = $0.date {
                    return Calendar.current.isDate(transactionDate, equalTo: lastMonth, toGranularity: .month)
                } else {
                    return false
                }
            }
        case .thisYear:
            transactions = transactions.filter {
                if let transactionDate = $0.date {
                    return Calendar.current.isDate(transactionDate, equalTo: currentDate, toGranularity: .year)
                } else {
                    return false
                }
            }
        case .lastYear:
            let lastYear = Calendar.current.date(byAdding: .year, 
                                                 value: -1, to: currentDate)
            ?? Utils.formatDate(date: .now)
            transactions = transactions.filter {
                if let transactionDate = $0.date {
                    return Calendar.current.isDate(transactionDate, equalTo: lastYear, toGranularity: .year)
                } else {
                    return false
                }
            }
        }
    }
}
