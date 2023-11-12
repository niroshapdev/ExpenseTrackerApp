//
//  AddExpenseViewModel.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation

class ExpensesViewModel: ObservableObject {
    private let service: ExpenseService
    
    @Published var expenses: [Expense] = []
    @Published var errorText: String = ""
    @Published var hasError: Bool = false
    
    init(service: ExpenseService = CoreDataExpenseService()) {
        self.service = service
    }
    
    func add(expense: Expense) {
        do {
            try service.addExpense(expense: expense)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.addExpenses
        }
    }
    
    func edit(expense: Expense) {
        do {
            try service.editExpense(expense: expense)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.editExpenses
        }
    }
    
    func delete(expense: Expense) {
        do {
            try service.deleteExpense(expense: expense)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.deleteExpenses
        }
    }
    
    func fetchExpenses() {
        do {
            expenses = try service.fetchExpenses()
            
            if expenses.count == 0 {
                hasError = true
                errorText = StringConstants.ErrorConstants.noExpenses
            }
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.fetchExpenses
        }
    }
}
