//
//  MockGoalsService.swift
//  ExpenseTrackerTests
//
//  Created by Nirosha Pabolu on 04/11/23.
//

import Foundation
@testable import ExpenseTracker

class MockGoalsService: GoalService {
    func addGoal(goal: ExpenseTracker.Goal) throws {
        // adding goal in coredata
        // not succuessful due to some reason
        // throw error in case of this
        
        throw GoalServiceErrors.addEdit
    }
    
    func fetchGoals() throws -> ExpenseTracker.Goals {
        throw GoalServiceErrors.fetch
    }
    
    func editGoal(goal: ExpenseTracker.Goal) throws {
        throw GoalServiceErrors.addEdit
    }
    
    func deleteGoal(goal: ExpenseTracker.Goal) throws {
        throw GoalServiceErrors.delete
    }
}
