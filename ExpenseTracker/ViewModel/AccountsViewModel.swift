//
//  AccountsViewModel.swift
//  AccountTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//
import Foundation

class AccountsViewModel: ObservableObject {
    let service: AccountService
    
    @Published var accounts: [Account] = []
    @Published var errorText: String = ""
    @Published var hasError: Bool = false
    @Published var totalBalance: Double = 0.0
    @Published var accountBalance: Double = 0.0
    var transactionViewModel = TransactionViewModel()
    @Published var transactions: Transactions = []
    @Published var balances: [String : Double] = [:]
    
    init(service: AccountService = CoreDataAccountService()) {
        self.service = service
    }
    
    func add(account: Account) {
        do {
            try service.addAccount(account: account)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.addAccounts
        }
    }
    
    func edit(account: Account) {
        do {
            try service.editAccount(account: account)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.editAccounts
        }
    }
    
    func delete(account: Account) {
        do {
            try service.deleteAccount(account: account)
            fetchAccounts()
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.deleteAccounts
        }
    }
    
    func fetchAccounts() {
        do {
            accounts = try service.fetchAccounts()
            if(transactions.isEmpty) {
                totalBalance = accounts.compactMap { $0.balance }.reduce(0.0, +)
            }
            if accounts.count == 0 {
                hasError = true
                errorText = StringConstants.ErrorConstants.noAccounts
            }
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.fetchAccounts
        }
    }
    
    func getUpdatedBalance(for account: Account) {
        transactionViewModel.fetchTransactions(for: account)
        transactions = transactionViewModel.transactions
        transactions = transactions.sorted {
            $0.date ?? Date() > $1.date ?? Date()
        }
        if transactions.count > 0 {
            for transaction in transactions {
                if let updatedBalance = transaction.updatedBalance?.toDouble() {
                    accountBalance = updatedBalance
                    balances[account.title ?? ""] = accountBalance
                    totalBalance = balances.values.reduce(0.0, +)
                    break
                }
            }
        } else {
            accountBalance = account.balance ?? 0.0
            balances[account.title ?? ""] = accountBalance
        }
    }
}
