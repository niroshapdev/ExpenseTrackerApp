//
//  MockAccountsService.swift
//  ExpenseTrackerTests
//
//  Created by Nirosha Pabolu on 06/11/23.
//

import Foundation
@testable import ExpenseTracker

class MockAccountService: AccountService {
    func addAccount(account: ExpenseTracker.Account) throws {
        throw AccountServiceErrors.addEdit
    }
    
    func fetchAccounts() throws -> ExpenseTracker.Accounts {
        throw AccountServiceErrors.fetch
    }
    
    func editAccount(account: ExpenseTracker.Account) throws {
        throw AccountServiceErrors.addEdit
    }
    
    func deleteAccount(account: ExpenseTracker.Account) throws {
        throw AccountServiceErrors.delete
    }
}

class MockAccountServiceNegativeScenario: AccountService {
    func addAccount(account: ExpenseTracker.Account) throws {
        throw AccountServiceErrors.addEdit
    }
    
    func fetchAccounts() throws -> ExpenseTracker.Accounts {
        []
    }
    
    func editAccount(account: ExpenseTracker.Account) throws {
        throw AccountServiceErrors.addEdit
    }
    
    func deleteAccount(account: ExpenseTracker.Account) throws {
        throw AccountServiceErrors.delete
    }
}
