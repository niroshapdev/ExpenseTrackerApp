//
//  ReportsViewModel.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 29/10/23.
//

import Foundation
import SwiftUI

class ReportsViewModel: ObservableObject {
    @Published var errorText: String = ""
    @Published var hasError: Bool = false
    @Published var categories: [Category] = []
    @Published var transactions: [Transaction] = []
    @Published var incomeChartData: [ChartData] = []
    @Published var expenseChartData: [ChartData] = []
    
    @ObservedObject var transactionsViewModel = TransactionViewModel()
    
    var incomeTransactions: Transactions {
        return transactions.filter { $0.type == .credit}
    }
    
    var expenseTransactions: Transactions {
        return transactions.filter { $0.type == .debit}
    }
    
    func getTransactions() {
        transactionsViewModel.fetchTransactions()
        transactions = transactionsViewModel.transactions
        getIncomeData()
        getExpenseData()
    }
    
    func getTransactions(fromDate: Date, toDate: Date) {
        transactionsViewModel.fetchTransactions()
        transactionsViewModel.filterTransactionsByCustomDate(fromDate: fromDate, toDate: toDate)
        transactions = transactionsViewModel.transactions
        getIncomeData()
        getExpenseData()
    }
    
    func filterTransactions(for filter: TransactionFilter) {
        transactionsViewModel.fetchTransactions()
        transactionsViewModel.filterTransactions(for: filter)
        transactions = transactionsViewModel.transactions
        getIncomeData()
        getExpenseData()
    }
    
    private func getExpenseData() {
        expenseChartData.removeAll()
        for transaction in expenseTransactions {
            expenseChartData.append(
                ChartData(
                    amount: (transaction.amount ?? 0.0),
                    color: Utils.colorFromHex(transaction.category?.color
                                              ?? DefaultConstants.colorString)
                                               ?? DefaultConstants.defaultColor
                ))
        }
    }
    
    private func getIncomeData() {
        incomeChartData.removeAll()
        for transaction in incomeTransactions {
            incomeChartData.append(
                ChartData(
                    amount: (transaction.amount ?? 0.0),
                    color: Utils.colorFromHex(transaction.category?.color 
                                              ?? DefaultConstants.colorString)
                                               ?? DefaultConstants.defaultColor
                ))
        }
    }
    
    func getTotalExpenses() -> Double {
        var totalAmount: Double = 0.0
        for transaction in expenseTransactions {
            totalAmount += transaction.amount ?? 0.0
        }
        return totalAmount
    }
    
    func getTotalIncome() -> Double {
        var totalAmount: Double = 0.0
        for transaction in incomeTransactions {
            totalAmount += transaction.amount ?? 0.0
        }
        return totalAmount
    }
    
    func getCategoryTitle(transaction: Transaction) -> String {
        transactionsViewModel.getCategoryTitle(transaction: transaction)
    }
    
    func getCategoryIcon(transaction: Transaction) -> String {
        transactionsViewModel.getCategoryIcon(transaction: transaction)
    }
}
