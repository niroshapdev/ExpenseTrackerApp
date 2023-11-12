//
//  TransactionViewModelTests.swift
//  ExpenseTrackerTests
//
//  Created by Nirosha Pabolu on 04/11/23.
//

import XCTest
@testable import ExpenseTracker

class TransactionViewModelTests: XCTestCase {
    var sut: TransactionViewModel!
    var accountViewModel: AccountsViewModel?
    var categoryViewModel: CategoryViewModel?
    
    override func setUp() {
        super.setUp()
        sut = TransactionViewModel(service: CoreDataTransactionService())
        accountViewModel = AccountsViewModel(service: CoreDataAccountService())
        categoryViewModel = CategoryViewModel(service: CoreDataCategoryService())
    }
    
    func testAddTransaction() throws {
        // Given
        try addTestTransaction()
        
        // Fetch transactions
        sut.fetchTransactions()
        
        // Then
        XCTAssertFalse(sut.hasError)
        XCTAssertGreaterThan(sut.transactions.count , 0)
    }
    
    func testEditTransaction() throws {
        // Given
        let accountViewModel = try XCTUnwrap(accountViewModel)
        let categoryViewModel = try XCTUnwrap(categoryViewModel)
        let account = Account(balance: 1000.0, title: "Test Account", currency: .usd, notes: "")
        accountViewModel.add(account: account)
        let category = Category(
            id: UUID(), title: "Test Category", color: "Red", 
            icon: IconConstants.plus, type: .income, date: Utils.formatDate(date: .now))
        categoryViewModel.add(category: category)
        let transaction = Transaction(
            type: .debit, account: account, category: category,
            amount: 500.0, date: Date(), status: .overdue, notes: "")
        sut.add(transaction: transaction)
        
        // When
        let updatedTransaction = Transaction(
            id: transaction.id, type: .credit, account: account,
            category: category, amount: 200.0,
            date: transaction.date,
            status: .planned, notes: "Updated Notes")
        sut.edit(transaction: updatedTransaction)
        
        sut.fetchTransactions()
        
        // Then
        XCTAssertFalse(sut.hasError)
        XCTAssertTrue(sut.transactions.contains {
            $0.date == updatedTransaction.date &&
            $0.notes == "Updated Notes"
        })
    }
    
    func testFetchTransactions() {
        // When
        sut.fetchTransactions()
        
        // Then
        XCTAssertFalse(sut.hasError)
        XCTAssertNotNil(sut.transactions)
    }
    
    func testDeleteTransaction() throws {
        // Given
        let account = Account(balance: 1000.0, title: "Test Account", currency: .usd, notes: "")
        let accountViewModel = try XCTUnwrap(accountViewModel)
        accountViewModel.add(account: account)
        
        let category = Category(id:
                                    UUID(uuidString: "55bd7af2-fda6-4e13-9b98-4ba5f11bfca1") ?? UUID(),
                                title: "Test Category", color: "Red",
                                icon: IconConstants.plus, type: .income, date: Utils.formatDate(date: .now))
        let categoryViewModel = try XCTUnwrap(categoryViewModel)
        categoryViewModel.add(category: category)
        
        let transaction = Transaction(
            type: .debit, account: account, category: category,
            amount: 500.0, date: Date(), status: .paid, notes: "",updatedBalance: "2000")
        
        // When
        sut.add(transaction: transaction)
        // When
        sut.delete(transaction: transaction)
        sut.fetchTransactions()
        
        // Then
        XCTAssertFalse(sut.hasError)
        XCTAssertFalse(sut.transactions.contains { $0.date == transaction.date })
    }
    
    func addTestTransaction() throws {
        let accountViewModel = try XCTUnwrap(accountViewModel)
        let categoryViewModel = try XCTUnwrap(categoryViewModel)
        
        let account = Account(balance: 1000.0, title: "Test Account", currency: .usd, notes: "")
        
        accountViewModel.add(account: account)
        
        let category = Category(id:
                                    UUID(uuidString: "55bd7af2-fda6-4e13-9b98-4ba5f11bfca1") ?? UUID(),
                                title: "Test Category", color: "Red",
                                icon: IconConstants.plus, type: .income, date: Utils.formatDate(date: .now))
        categoryViewModel.add(category: category)

        // When
        sut.add(
            type: .debit, account: account, category: category,
            amount: 500.0, date: Date(), paymentStatus: .paid, notes: "",updatedBalance: "2000")
    }
}

extension TransactionViewModelTests {
    
    func testAddTransactionWithError() {
        let sut = TransactionViewModel(service: MockTransactionService())
        // Given
        let invalidTransaction = Transaction(type: .credit, account: nil,
                                             category: nil, amount: -100.0,
                                             date: Date(), status: .planned, notes: "")
        
        // When
        sut.add(transaction: invalidTransaction)
        
        // Then
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, StringConstants.ErrorConstants.addTransactions)
        XCTAssertFalse(sut.transactions.contains { $0.id == invalidTransaction.id })
    }
    
    func testEditTransactionWithError() throws {
        // GIVEN
        let sut = TransactionViewModel(service: MockTransactionService())
        let accountViewModel = try XCTUnwrap(accountViewModel)
        let categoryViewModel = try XCTUnwrap(categoryViewModel)
        let account = Account(balance: 1000.0, title: "Test Account", currency: .usd, notes: "")
        accountViewModel.add(account: account)
        let category = Category(id: UUID(), title: "Test Category", color: "Red", icon: IconConstants.plus,
                                type: .income, date: Utils.formatDate(date: .now))
        categoryViewModel.add(category: category)
        let transaction = Transaction(type: .credit, account: account,
                                      category: category, amount: 500.0,
                                      date: Date(), status: .paid, notes: "")
        sut.add(transaction: transaction)
        
        // When
        let invalidTransaction = Transaction(id: transaction.id, type: .credit,
                                             account: nil, category: nil, amount: -200.0,
                                             date: Date(), status: .planned, notes: "Updated Notes")
        sut.edit(transaction: invalidTransaction)
        sut.add(transaction: invalidTransaction)
        
        // Then
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, StringConstants.ErrorConstants.addTransactions)
        XCTAssertFalse(sut.transactions.contains { $0.id == invalidTransaction.id })
    }
    
    func testDeleteNonExistingTransaction() {
        // Given
        let sut = TransactionViewModel(service: MockTransactionService())
        let invalidTransaction = Transaction(id: UUID(), type: .debit,
                                             account: nil, category: nil, amount: 200.0,
                                             date: Date(), status: .planned, notes: "Invalid Transaction")
        // When
        sut.delete(transaction: invalidTransaction)
        
        // Then
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, StringConstants.ErrorConstants.deleteTransactions)
    }
}

extension TransactionViewModelTests {
    func testFetchTransactionsNewAccount() throws {
        let sut = TransactionViewModel(service: MockTransactionServiceNegativeScenario())
        sut.fetchTransactions()
        
        XCTAssertEqual(sut.transactions.count, 0)
    }
    
    func testFetchTransactionsErrorScenario() throws {
        let sut = TransactionViewModel(service: MockTransactionService())
        sut.fetchTransactions()
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, "Unable to fetch transactions")
    }
    
    func testFetchTransactionsForAccountErrorScenario() throws {
        let account = Account(title: "New Account")
        let accountViewModel = try XCTUnwrap(accountViewModel)
        accountViewModel.add(account: account)
        
        let sut = TransactionViewModel(service: MockTransactionService())
        sut.fetchTransactions(for: account)
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, "Unable to fetch transactions")
    }
}

extension TransactionViewModelTests {
    func testFilterTransactions() {
        for item in TransactionFilter.allCases {
            sut.filterTransactions(for: item)
        }
    }
}
