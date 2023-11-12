//
//  AccountsViewModelTests.swift
//  ExpenseTrackerTests
//
//  Created by Nirosha Pabolu on 06/11/23.
//

import XCTest
@testable import ExpenseTracker

final class AccountsViewModelTests: XCTestCase {
    
    var sut: AccountsViewModel?
    
    override func setUpWithError() throws {
        sut = AccountsViewModel(service: CoreDataAccountService())
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testAddAccount() throws {
        let account =  Account(id: UUID(uuidString: "68b696d7-320b-4402-a412-d9cee10fc6a3") ?? UUID(),
                               balance: 10000, title: "Test Wallet", currency: .inr)
        let sut = try XCTUnwrap(sut)
        sut.add(account: account)
        
        // Fetch accounts
        sut.fetchAccounts()
        
        XCTAssertFalse(sut.hasError)
        XCTAssertEqual(sut.errorText, "")
        XCTAssertGreaterThan(sut.accounts.count, 0)
    }
    
    func testFetchAccounts() throws {
        // Given
        let sut = try XCTUnwrap(sut)
        
        // When
        sut.fetchAccounts()
        
        // Then
        XCTAssertFalse(sut.hasError)
        XCTAssertEqual(sut.errorText, "")
        XCTAssertNotNil(sut.accounts)
        XCTAssertGreaterThan(sut.accounts.count, 0)
    }
    
    func testEditAccount() throws {
        // Given
        let sut = try XCTUnwrap(sut)
        let account =  Account(id: UUID() ,
                               balance: 20000, title: "My Wallet", currency: .inr)
        sut.add(account: account)
        
        // When
        let updatedAccount = Account(id: account.id ,
                                     balance: 30000, title: "Wallet", currency: .inr)
        sut.edit(account: updatedAccount)
        sut.fetchAccounts()
        
        // Then
        XCTAssertFalse(sut.hasError)
        XCTAssertEqual(sut.errorText, "")
        XCTAssertTrue(sut.accounts.contains {
            $0.title == updatedAccount.title
        })
    }
    
    func testDeleteAccount() throws {
        // Given
        let sut = try XCTUnwrap(sut)
        let account =  Account(id: UUID() ,
                               balance: 20000, title: "My Wallet", currency: .inr)
        sut.add(account: account)
        
        // When
        sut.delete(account: account)
        sut.fetchAccounts()
        
        // Then
        XCTAssertFalse(sut.hasError)
        XCTAssertFalse(sut.accounts.contains { $0.id == account.id })
    }
}

extension AccountsViewModelTests {
    
    func testAddAccountWithError() throws {
        // Given
        let sut = AccountsViewModel(service: MockAccountService())
        let account = Account(id: UUID() ,
                              balance: 20000, title: "Invalid Account", currency: .inr)
        
        // When
        sut.add(account: account)
        
        // Then
        XCTAssertFalse(sut.accounts.contains { $0.id == account.id })
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, StringConstants.ErrorConstants.addAccounts)
    }
    
    func testEditAccountWithError() {
        // Given
        let sut = AccountsViewModel(service: MockAccountService())
        let account = Account(id: UUID() ,
                              balance: 1000, title: "Test Account", currency: .inr)
        sut.add(account: account)
        
        // When
        let updatedAccount = Account(id: account.id,
                                     balance: 30000, title: "Wallet", currency: .inr)
        sut.edit(account: updatedAccount)
        
        // Then
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, StringConstants.ErrorConstants.editAccounts)
        XCTAssertFalse(sut.accounts.contains { $0.id == updatedAccount.id && $0.title == updatedAccount.title })
    }
    
    func testDeleteNonExistingGoal() {
        // Given
        let sut = AccountsViewModel(service: MockAccountService())
        let account = Account(id: UUID(),
                           balance: 100, title: "Non existing Account", currency: .usd)
        
        // When
        sut.delete(account: account)
        
        // Then
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, StringConstants.ErrorConstants.deleteAccounts)
    }
    
    func testFetchAccountsWithErrors() {
        // Given
        let sut = AccountsViewModel(service: MockAccountService())
        
        // When
        sut.fetchAccounts()
        
        // Then
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, StringConstants.ErrorConstants.fetchAccounts)
    }
    
    func testFetchNoAccounts() {
        // Given
        let sut = AccountsViewModel(service: MockAccountServiceNegativeScenario())
        
        // When
        sut.fetchAccounts()
        
        // Then
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.accounts.count, 0)
    }
    
    func testUpdatedBalanceForAccount() throws {
        sut?.fetchAccounts()
        let account = sut?.accounts.first ?? Account(title: "Test Account")
        sut?.getUpdatedBalance(for: account)
        XCTAssertNotEqual(sut?.totalBalance, 0.0)
    }
    
    func testUpdatedBalanceForAccountNoTransactions() throws {
        let sut = try XCTUnwrap(sut)
        let account = Account(title: "Test Account No Transactions")
        sut.add(account: account)
        sut.transactionViewModel.fetchTransactions(for: account)
        sut.getUpdatedBalance(for: account)
        XCTAssertEqual(sut.totalBalance, 0.0)
    }
}
