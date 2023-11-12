//
//  DeveloperModeView.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import SwiftUI

struct DeveloperModeView: View {

    var body: some View {
        printDBPathView
        categoriesView
        accountsView
        goalsView
        transactionsView
    }
    
    private var categoriesView: some View {
        Button("Insert Categories") {
            // Create test data for categories to insert
            for anItem in TestData.categories {
                CategoryViewModel(service: CoreDataCategoryService())
                    .add(category: anItem)
            }
        }
    }
    
    private var accountsView: some View {
        Button("Insert Accounts") {
            // Create test data for accounts to insert
            for anItem in TestData.accounts {
                AccountsViewModel(service: CoreDataAccountService())
                    .add(account: anItem)
            }
        }
    }
    
    private var goalsView: some View {
        Button("Insert Goals") {
            // Create test data for goals to insert
            for anItem in TestData.goals {
                GoalsViewModel(service: CoreDataGoalService())
                    .add(goal: anItem)
            }
        }
    }
    
    private var transactionsView: some View {
        Button("Insert Transactions") {
            // Create test data for transactions to insert
            for anItem in TestData.transactions {
                TransactionViewModel(service: CoreDataTransactionService())
                    .add(transaction: anItem)
            }
        }
    }
    
    private var printDBPathView: some View {
        Button("Print SQLite Path") {
            let path = FileManager.default.urls(for: .documentDirectory,
                                                in: .userDomainMask).last
            
            Logger.log("Documents Directory: \(String(describing: path))", level: .info)
        }
    }
}

#Preview {
    DeveloperModeView()
}
