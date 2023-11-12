//
//  GoalsViewModelTests.swift
//  ExpenseTrackerTests
//
//  Created by Nirosha Pabolu on 03/11/23.
//

import XCTest
@testable import ExpenseTracker

final class GoalsViewModelTests: XCTestCase {
    var sut: GoalsViewModel?
    
    override func setUpWithError() throws {
        sut = GoalsViewModel(service: CoreDataGoalService())
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testAddGoal() throws {
        let goal = Goal(
            id: UUID(uuidString: "249a2478-7b0c-11ee-b962-0242ac120002") ?? UUID(),
            title: "Goal 1",
            targetAmount: 100000,
            savedAmount: 10000,
            currency: "INR"
        )
        
        let sut = try XCTUnwrap(sut)
        sut.add(goal: goal)
        
        // Fetch goals
        sut.fetchGoals()
        
        XCTAssertFalse(sut.hasError)
        XCTAssertEqual(sut.errorText, "")
        XCTAssertGreaterThan(sut.goals.count, 0)
    }
    
    func testFetchGoals() throws {
        // Given
        let sut = try XCTUnwrap(sut)
        
        // When
        sut.fetchGoals()
        
        // Then
        XCTAssertFalse(sut.hasError)
        XCTAssertEqual(sut.errorText, "")
        XCTAssertNotNil(sut.goals)
        XCTAssertGreaterThan(sut.goals.count, 0)
    }
    
    func testEditGoal() throws {
        // Given
        let sut = try XCTUnwrap(sut)
        let goal = Goal(id: UUID(), title: "Test Goal", targetAmount: 100.0, savedAmount: 0.0, currency: "USD")
        sut.add(goal: goal)
        
        // When
        let updatedGoal = Goal(id: goal.id, 
                               title: "Updated Goal", 
                               targetAmount: 200.0,
                               savedAmount: 50.0, currency: "EUR")
        sut.edit(goal: updatedGoal)
        sut.fetchGoals()
        
        // Then
        XCTAssertFalse(sut.hasError)
        XCTAssertEqual(sut.errorText, "")
        XCTAssertTrue(sut.goals.contains { 
            $0.title == updatedGoal.title
        })
    }
    
    func testDeleteGoal() throws {
        // Given
        let sut = try XCTUnwrap(sut)
        let goal = Goal(id: UUID(), title: "Test Goal", targetAmount: 100.0, savedAmount: 0.0, currency: "USD")
        sut.add(goal: goal)
        
        // When
        sut.delete(goal: goal)
        sut.fetchGoals()
        
        // Then
        XCTAssertFalse(sut.hasError)
        XCTAssertFalse(sut.goals.contains { $0.id == goal.id })
    }
}

extension GoalsViewModelTests {
    
    func testAddGoalWithError() throws {
        // Given
        let sut = GoalsViewModel(service: MockGoalsService())
        let goal = Goal(id: UUID(), title: "Invalid Goal", targetAmount: -10.0, savedAmount: 0.0, currency: "USD")
        
        // When
        sut.add(goal: goal)
        
        // Then
        XCTAssertFalse(sut.goals.contains { $0.id == goal.id })
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, StringConstants.ErrorConstants.addGoals)
    }
    
    func testEditGoalWithError() {
        // Given
        let sut = GoalsViewModel(service: MockGoalsService())
        let goal = Goal(id: UUID(), title: "Test Goal", targetAmount: 100.0, savedAmount: 0.0, currency: "USD")
        sut.add(goal: goal)
        
        // When
        let updatedGoal = Goal(id: goal.id, title: "Updated Goal", 
                               targetAmount: -50.0, savedAmount: 50.0, currency: "EUR")
        sut.edit(goal: updatedGoal)
        
        // Then
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, StringConstants.ErrorConstants.editGoals)
        XCTAssertFalse(sut.goals.contains { $0.id == updatedGoal.id && $0.title == updatedGoal.title })
    }
    
    func testDeleteNonExistingGoal() {
        // Given
        let sut = GoalsViewModel(service: MockGoalsService())
        let goal = Goal(id: UUID(), title: "Non-Existing Goal", targetAmount: 100.0, savedAmount: 0.0, currency: "USD")
        
        // When
        sut.delete(goal: goal)
        
        // Then
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, StringConstants.ErrorConstants.deleteGoals)
    }
    
    func testFetchGoalsWithErrors() {
        // Given
        let sut = GoalsViewModel(service: MockGoalsService())
        
        // When
        sut.fetchGoals()
        
        // Then
        XCTAssertTrue(sut.hasError)
        XCTAssertEqual(sut.errorText, StringConstants.ErrorConstants.fetchGoals)
    }
}
