//
//  MockTransactionService.swift
//  ExpenseTrackerTests
//
//  Created by Nirosha Pabolu on 04/11/23.
//

import Foundation
@testable import ExpenseTracker

class MockTransactionService: TransactionService {
    func addTransaction(transaction: Transaction) throws {
        throw TransactionServiceErrors.addEdit
    }
    
    func fetchTransactions() throws -> Transactions {
        throw TransactionServiceErrors.fetch
    }
    
    func editTransaction(transaction: Transaction) throws {
        throw TransactionServiceErrors.addEdit
        
    }
    
    func deleteTransaction(transaction: Transaction) throws {
        throw TransactionServiceErrors.delete
    }
    
    func fetchTransactions(for account: Account) throws -> Transactions {
        throw TransactionServiceErrors.fetch
    }
}

class MockTransactionServiceNegativeScenario: TransactionService {
    func addTransaction(transaction: Transaction) throws {
        throw TransactionServiceErrors.addEdit
    }
    
    func fetchTransactions() throws -> Transactions {
        []
    }
    
    func editTransaction(transaction: Transaction) throws {
        throw TransactionServiceErrors.addEdit
        
    }
    
    func deleteTransaction(transaction: Transaction) throws {
        throw TransactionServiceErrors.delete
    }
    
    func fetchTransactions(for account: Account) throws -> Transactions {
        throw TransactionServiceErrors.fetch
    }
}
