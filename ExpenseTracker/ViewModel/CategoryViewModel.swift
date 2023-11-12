//
//  CategoryViewModel.swift
//  CategoryTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation

class CategoryViewModel: ObservableObject {
    let service: CategoryService
    
    @Published var categories: Categories = []
    @Published var errorText: String = ""
    @Published var hasError: Bool = false
    @Published var incomeCategories: Categories = []
    @Published var expenseCategories: Categories = []
    
    init(service: CategoryService = CoreDataCategoryService()) {
        self.service = service
    }
    
    func add(title: String, color: String, icon: String, type: CategoryType) {
        let category = Category(
            title: title, color: color,
            icon: icon, type: type, date: Utils.formatDate(date: .now))
        add(category: category)
    }
    
    func add(category: Category) {
        do {
            try service.addCategory(category: category)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.addCategories
        }
    }
    
    func edit(category: Category) {
        do {
            try service.editCategory(category: category)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.editCategories
        }
    }
    
    func delete(category: Category) {
        do {
            try service.deleteCategory(category: category)
            fetchCategories()
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.deleteCategories
        }
    }
    
    func fetchCategories() {
        do {
            categories = try service.fetchCategories()
            incomeCategories = categories.filter { $0.type == .income}
            expenseCategories = categories.filter { $0.type == .expense}
            
            if categories.count == 0 {
                hasError = true
                errorText = StringConstants.ErrorConstants.noCategories
            }
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.fetchCategories
        }
    }
}
