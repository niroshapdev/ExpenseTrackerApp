//
//  MockCategoryService.swift
//  ExpenseTrackerTests
//
//  Created by Nirosha Pabolu on 04/11/23.
//

import Foundation
@testable import ExpenseTracker

class MockCategoryService: CategoryService {
    func addCategory(category: ExpenseTracker.Category) throws {
        throw CategoryServiceErrors.addEdit
    }
    
    func fetchCategories() throws -> ExpenseTracker.Categories {
        throw CategoryServiceErrors.fetch
    }
    
    func editCategory(category: ExpenseTracker.Category) throws {
        throw CategoryServiceErrors.addEdit
    }
    
    func deleteCategory(category: ExpenseTracker.Category) throws {
        throw CategoryServiceErrors.delete
    }
}
