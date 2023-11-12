//
//  GoalService.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation

enum GoalServiceErrors: String, Error {
    case addEdit = "Could not save the goal"
    case fetch = "Could not fetch the goal"
    case update = "Could not find the goal to update"
    case delete = "Could not find the goal to delete"
    case noRecord = "Could not find the goal"
}

public protocol GoalService {
    func addGoal(goal: Goal) throws
    func fetchGoals() throws -> Goals
    func editGoal(goal: Goal) throws
    func deleteGoal(goal: Goal) throws
}
