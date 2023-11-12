//
//  ReportsViewModelTests.swift
//  ExpenseTrackerTests
//
//  Created by Nirosha Pabolu on 06/11/23.
//

import XCTest
@testable import ExpenseTracker

class ReportsViewModelTests: XCTestCase {

    var reportsViewModel: ReportsViewModel!
    var accountViewModel: AccountsViewModel!
    var categoryViewModel: CategoryViewModel!
    let account = Account(balance: 1000.0, title: "Test Account", currency: .usd, notes: "")
    let category = Category(
        id: UUID(), title: "Test Category", color: "Red",
        icon: IconConstants.plus, type: .income, date: Utils.formatDate(date: .now))
    
    override func setUp() {
        super.setUp()
        reportsViewModel = ReportsViewModel()
        accountViewModel = AccountsViewModel(service: CoreDataAccountService())
        categoryViewModel = CategoryViewModel(service: CoreDataCategoryService())
    }

    override func tearDown() {
        reportsViewModel = nil
        super.tearDown()
    }

    func testGetTransactions() {
        reportsViewModel.getTransactions()
        XCTAssertFalse(reportsViewModel.transactions.isEmpty)
        XCTAssertTrue(reportsViewModel.incomeChartData.count > 0)
        XCTAssertTrue(reportsViewModel.expenseChartData.count > 0)
    }

    func testTotalExpenses() {
        let transaction1 = Transaction(type: .debit, account: account, category: category,
                                      amount: 500.0, date: Date(), status: .overdue, notes: "")
        let transaction2 = Transaction(type: .debit, account: account, category: category,
                                      amount: 600.0, date: Date(), status: .overdue, notes: "")
        
        let expenseTransaction1 = transaction1
        let expenseTransaction2 = transaction2
        reportsViewModel.transactions = [expenseTransaction1, expenseTransaction2]
        XCTAssertEqual(reportsViewModel.getTotalExpenses(), 1100.0)
    }

    func testTotalIncome() {
        let transaction1 = Transaction(type: .credit, account: account, category: category,
                                      amount: 100.0, date: Date(), status: .overdue, notes: "")
        let transaction2 = Transaction(type: .credit, account: account, category: category,
                                      amount: 150.0, date: Date(), status: .overdue, notes: "")
        
        let incomeTransaction1 = transaction1
        let incomeTransaction2 = transaction2
        reportsViewModel.transactions = [incomeTransaction1, incomeTransaction2]
        XCTAssertEqual(reportsViewModel.getTotalIncome(), 250.0)
    }

    func testIncomeTransactions() {
        let transaction1 = Transaction(type: .credit, account: account, category: category,
                                      amount: 50, date: Date(), status: .overdue, notes: "")
        let transaction2 = Transaction(type: .debit, account: account, category: category,
                                      amount: 30, date: Date(), status: .overdue, notes: "")
        
        let creditTransaction = transaction1
        let debitTransaction = transaction2
        reportsViewModel.transactions = [creditTransaction, debitTransaction]
        XCTAssertEqual(reportsViewModel.incomeTransactions.count, 1)
    }

    func testExpenseTransactions() {
        let transaction1 = Transaction(type: .credit, account: account, category: category,
                                      amount: 50, date: Date(), status: .overdue, notes: "")
        let transaction2 = Transaction(type: .debit, account: account, category: category,
                                      amount: 30, date: Date(), status: .overdue, notes: "")
        
        let creditTransaction = transaction1
        let debitTransaction = transaction2
        reportsViewModel.transactions = [creditTransaction, debitTransaction]
        XCTAssertEqual(reportsViewModel.expenseTransactions.count, 1)
    }
    
    func testGetTransactionsWithDateFilter() {
        reportsViewModel.getTransactions(
            fromDate: Utils.stringToDate("27-June-2022 8:00PM"),
            toDate: .now)
        XCTAssertFalse(reportsViewModel.transactions.isEmpty)
        XCTAssertGreaterThan(reportsViewModel.transactions.count, 0)
    }
    
    func testGetTransactionsWithFilter() {
        reportsViewModel.filterTransactions(for: .last30days)
        XCTAssertFalse(reportsViewModel.transactions.isEmpty)
        XCTAssertGreaterThan(reportsViewModel.transactions.count, 0)
    }

    func testCategoryTitle() throws {
        reportsViewModel.getTransactions()
        let transaction = try XCTUnwrap(reportsViewModel.transactions.first)
        let title = reportsViewModel.getCategoryTitle(transaction: transaction)
        XCTAssertNotEqual(title, "")
    }
    
    func testCategoryIcon() throws {
        reportsViewModel.getTransactions()
        let transaction = try XCTUnwrap(reportsViewModel.transactions.first)
        let title = reportsViewModel.getCategoryIcon(transaction: transaction)
        XCTAssertNotEqual(title, "")
    }
}
