//
//  CategoryViewModelTests.swift
//  ExpenseTrackerTests
//
//  Created by Nirosha Pabolu on 04/11/23.
//

import XCTest
@testable import ExpenseTracker

class CategoryViewModelTests: XCTestCase {
    var viewModel: CategoryViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CategoryViewModel(service: CoreDataCategoryService())
    }
    
    // This test will pass, only when items are not availble in the DB
    // we can test this on app first launch
//    func testFetchCategoriesNoItems() {
//        // When
//        viewModel.fetchCategories()
//
//        // Then
//        XCTAssertTrue(viewModel.hasError)
//        XCTAssertEqual(viewModel.categories.count, 0)
//        XCTAssertTrue(viewModel.incomeCategories.isEmpty)
//        XCTAssertTrue(viewModel.expenseCategories.isEmpty)
//    }
    
    func testAddCategory() {
        // Given
        let category = Category(
            title: "Test Category", color: "Red", 
            icon: IconConstants.plus, type: .income, date: Utils.formatDate(date: .now))
        
        // When
        viewModel.add(category: category)
        viewModel.add(
            title: "Test Expense Category", color: "Red",
            icon: IconConstants.plus, type: .expense)
        viewModel.fetchCategories()
        
        // Then
        XCTAssertFalse(viewModel.hasError)
        XCTAssertTrue(viewModel.categories.contains { $0.id == category.id })
    }
    
    func testEditCategory() {
        // Given
        let category = Category(title: "Test Category", color: "Red", 
                                icon: IconConstants.plus, type: .income, date: Utils.formatDate(date: .now))
        viewModel.add(category: category)
        
        // When
        let updatedCategory = Category(id: category.id, title: "Updated Category", 
                                       color: "Blue", icon: IconConstants.plus,
                                       type: .expense, date: Utils.formatDate(date: .now))
        viewModel.edit(category: updatedCategory)
        viewModel.fetchCategories()
        
        // Then
        XCTAssertFalse(viewModel.hasError)
        XCTAssertTrue(viewModel.categories.contains {
            $0.id == updatedCategory.id && $0.title == updatedCategory.title })
    }
    
    func testDeleteCategory() {
        // Given
        let category = Category(
            title: "This category will be deleted", color: "Red",
            icon: IconConstants.plus, type: .income, date: Utils.formatDate(date: .now))
        viewModel.add(category: category)
        
        // When
        viewModel.delete(category: category)
        viewModel.fetchCategories()
        
        // Then
        XCTAssertFalse(viewModel.hasError)
    }
    
    func testFetchCategories() {
        // When
        viewModel.fetchCategories()
        
        // Then
        XCTAssertFalse(viewModel.hasError)
        XCTAssertNotNil(viewModel.categories)
        XCTAssertFalse(viewModel.incomeCategories.isEmpty)
        XCTAssertFalse(viewModel.expenseCategories.isEmpty)
    }
    
    func testAddCategoryWithError() {
        // Given
        let viewModel = CategoryViewModel(service: MockCategoryService())
        let category = Category(title: "", color: "Red", icon: "icon", type: .income,
                                date: Utils.formatDate(date: .now))
        
        // When
        viewModel.add(category: category)
        
        // Then
        XCTAssertTrue(viewModel.hasError)
        XCTAssertEqual(viewModel.errorText, StringConstants.ErrorConstants.addCategories)
        XCTAssertFalse(viewModel.categories.contains {
            $0.id == category.id
        })
    }
    
    func testEditCategoryWithError() {
        // Given
        let viewModel = CategoryViewModel(service: MockCategoryService())
        let category = Category(title: "Test Category", color: "Red", icon: IconConstants.plus, 
                                type: .income, date: Utils.formatDate(date: .now))
        viewModel.add(category: category)
        
        // When
        let updatedCategory = Category(id: category.id, title: "", color: "Blue", 
                                       icon: "newIcon", type: .expense, date: Utils.formatDate(date: .now))
        viewModel.edit(category: updatedCategory)
        
        // Then
        XCTAssertTrue(viewModel.hasError)
        XCTAssertEqual(viewModel.errorText, StringConstants.ErrorConstants.editCategories)
        XCTAssertFalse(viewModel.categories.contains {
            //            $0.id == updatedCategory.id &&
            $0.title == updatedCategory.title
        })
    }
    
    func testDeleteNonExistingCategory() {
        // Given
        let viewModel = CategoryViewModel(service: MockCategoryService())
        let category = Category(title: "Non-Existing Category", color: "Red", 
                                icon: "icon", type: .income, date: Utils.formatDate(date: .now))
        
        // When
        viewModel.delete(category: category)
        
        // Then
        XCTAssertTrue(viewModel.hasError)
        XCTAssertEqual(viewModel.errorText, StringConstants.ErrorConstants.deleteCategories)
    }
}
