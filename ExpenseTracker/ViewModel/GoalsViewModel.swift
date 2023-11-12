//
//  AddGoalViewModel.swift
//  GoalTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation
class GoalsViewModel: ObservableObject {
    @Published var goals: [Goal] = []
    @Published var errorText: String = ""
    @Published var hasError: Bool = false
   
    let service: GoalService
    
    init(service: GoalService = CoreDataGoalService()) {
        self.service = service
    }
    
    func add(goal: Goal) {
        do {
            try service.addGoal(goal: goal)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.addGoals
        }
    }
    
    func edit(goal: Goal) {
        do {
            try service.editGoal(goal: goal)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.editGoals
        }
    }
    
    func delete(goal: Goal) {
        do {
            try service.deleteGoal(goal: goal)
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.deleteGoals
        }
    }
    
    func fetchGoals() {
        do {
            goals = try service.fetchGoals()
        } catch {
            hasError = true
            errorText = StringConstants.ErrorConstants.fetchGoals
        }
    }
}
