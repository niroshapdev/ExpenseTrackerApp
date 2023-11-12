//
//  BalanceManager.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 05/11/23.
//

import Foundation

class BalanceManager {
    static var currentBalances: [String: Double] = [:]

    static func getUpdatedBalance(amount: Double, accountTitle: String,
                                  accountBalance: Double, type: TransactionType) -> String {
        if let balance = BalanceManager.currentBalances[accountTitle] {
            let isDebitOrNegative = (amount < 0) || (type == .debit)
            let updatedBalance: Double

            if isDebitOrNegative {
                updatedBalance = balance - amount
            } else {
                updatedBalance = balance + amount
            }

            BalanceManager.currentBalances[accountTitle] = updatedBalance

            let prefix = updatedBalance < 0 ? "-" : ""
            let updatedBalanceStr = String(format: "%@%.2f", prefix, abs(updatedBalance))
            return updatedBalanceStr
        } else {
            // If the currentBalance for the account is nil, fetch the initial balance from transaction.account.balance
            BalanceManager.currentBalances[accountTitle] = accountBalance
            return getUpdatedBalance(amount: amount, accountTitle: accountTitle, 
                                     accountBalance: accountBalance, type: type)
        }
    }
}
