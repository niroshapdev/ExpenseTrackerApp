////
////  TodayViewModel.swift
////  ExpenseTracker
////
////  Created by Nirosha Pabolu on 17/10/23.
////
//
import SwiftUI

class TodayViewModel: ObservableObject {
    
    @ObservedObject var transactionViewModel = TransactionViewModel()
    @ObservedObject var goalsViewModel = GoalsViewModel()
    
    @Published var transactions: Transactions = []
    @Published var goals: Goals = []
    
    func fetchData() {
        self.fetchGoals()
        self.fetchTransactions()
    }

    func fetchTransactions() {
        transactionViewModel.fetchTransactions()
        transactions = transactionViewModel.transactions
    }
    
    func fetchGoals() {
        goalsViewModel.fetchGoals()
        goals = goalsViewModel.goals
    }
}
