//
//  CategoryService.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation

enum CategoryServiceErrors: String, Error {
    case addEdit = "Could not save the category"
    case fetch = "Could not fetch the category"
    case update = "Could not find the category to update"
    case delete = "Could not find the category to delete"
    case noRecord = "Could not find the category"
}

public protocol CategoryService {
    func addCategory(category: Category) throws
    func fetchCategories() throws -> Categories
    func editCategory(category: Category) throws
    func deleteCategory(category: Category) throws
}
