//
//  CoreDataGoalsService.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation
import CoreData

struct CoreDataGoalService: GoalService {
    func addGoal(goal: Goal) throws {
        let entity = NSEntityDescription.entity(forEntityName: "GoalEntity", in: CoreDataStack.shared.context)!
        let goalItem = GoalEntity(entity: entity, insertInto: CoreDataStack.shared.context)
        goalItem.targetAmount = goal.targetAmount ?? 0.0
        goalItem.savedAmount = goal.savedAmount ?? 0.0
        goalItem.id = goal.id.uuidString
        goalItem.title = goal.title
        goalItem.currency = goal.currency
    
        try CoreDataStack.shared.saveContext()
    }
    
    func fetchGoals() throws -> Goals {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        
        do {
            let goalEntities = try CoreDataStack.shared.context.fetch(fetchRequest)
            return goalEntities.map {
                Goal(
                    id: $0.id?.toUUID() ?? UUID(),
                    title: $0.title,
                    targetAmount: $0.targetAmount,
                    savedAmount: $0.savedAmount,
                    currency: $0.currency
                )
            }
        } catch {
            throw CoreDataManagerErrors.fetch
        }
    }
    
    func editGoal(goal: Goal) throws {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [goal.id as CVarArg])
        
        do {
            if let existingRecord = try CoreDataStack.shared.context.fetch(fetchRequest).first {
                existingRecord.targetAmount = goal.targetAmount ?? 0.0
                existingRecord.savedAmount = goal.savedAmount ?? 0.0
                existingRecord.id = goal.id.uuidString
                existingRecord.currency = goal.currency
                existingRecord.title = goal.title
                try CoreDataStack.shared.saveContext()
            } else {
                throw CoreDataManagerErrors.noRecord
            }
        } catch {
            throw CoreDataManagerErrors.save
        }
    }
    
    func deleteGoal(goal: Goal) throws {
        let fetchRequest: NSFetchRequest<GoalEntity> = GoalEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [goal.id as CVarArg])
        
        do {
            if let existingRecord = try CoreDataStack.shared.context.fetch(fetchRequest).first {
                CoreDataStack.shared.context.delete(existingRecord)
                try CoreDataStack.shared.saveContext()
            } else {
                throw CoreDataManagerErrors.noRecord
            }
        } catch {
            throw CoreDataManagerErrors.delete
        }
    }
}
