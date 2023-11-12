//
//  AccountService.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation
enum AccountServiceErrors: String, Error {
    case addEdit = "Could not save the account"
    case noRecord = "Could not find the account"
    case fetch = "Could not fetch the account"
    case update = "Could not find the account to update"
    case delete = "Could not find the account to delete"
}

public protocol AccountService {
    func addAccount(account: Account) throws
    func fetchAccounts() throws -> Accounts
    func editAccount(account: Account) throws
    func deleteAccount(account: Account) throws
}
