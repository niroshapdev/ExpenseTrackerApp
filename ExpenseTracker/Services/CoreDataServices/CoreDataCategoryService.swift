//
//  CoreDataCategoryService.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation
import CoreData

enum CoreDataManagerErrors: Error {
    case save, fetch, update, delete, noRecord
}

struct CoreDataCategoryService: CategoryService {
    /// Method: Add an category to core data entity
    /// Parameters: Category
    /// Returns: none
    func addCategory(category: Category) throws {
        let entity = NSEntityDescription.entity(forEntityName: "CategoryEntity", in: CoreDataStack.shared.context)!
        let categoryEntity = CategoryEntity(entity: entity, insertInto: CoreDataStack.shared.context)
        categoryEntity.color = category.color
        categoryEntity.id = category.id.uuidString
        categoryEntity.icon = category.icon
        categoryEntity.title = category.title
        categoryEntity.type = category.type?.rawValue
        categoryEntity.date = category.date
    
        try CoreDataStack.shared.saveContext()
    }
    
    /// Method: Add an category to core data entity
    /// Parameters: none
    /// Returns: Categories
    func fetchCategories() throws -> Categories {
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        do {
            let items = try CoreDataStack.shared.context.fetch(fetchRequest)
            return items.map {
                Category(id:    $0.id?.toUUID() ?? UUID(),
                         title: $0.title,
                         color: $0.color,
                         icon:  $0.icon, 
                         type: CategoryType(rawValue: $0.type ?? StringConstants.TodayViewConstants.income),
                         date: $0.date ?? Utils.formatDate(date: .now)
                )
            }
        } catch {
            throw CoreDataManagerErrors.fetch
        }
    }
    
    /// Method: Edit selected category and save it to core data entity
    /// Parameters: Category
    /// Returns: none
    func editCategory(category: Category) throws {
        guard let date = category.date else {
            throw CoreDataManagerErrors.noRecord
        }
        
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", argumentArray: [date as CVarArg])
        
        do {
            if let existingRecord = try CoreDataStack.shared.context.fetch(fetchRequest).first {
                existingRecord.title = category.title
                existingRecord.id = category.id.uuidString
                existingRecord.icon = category.icon
                existingRecord.color = category.color
                existingRecord.type = category.type?.rawValue
                try CoreDataStack.shared.saveContext()
            } else {
                throw CoreDataManagerErrors.noRecord
            }
        } catch {
            throw CoreDataManagerErrors.save
        }
    }
    
    /// Method: Delete the selected category from core data entity
    /// Parameters: Category
    /// Returns: none
    func deleteCategory(category: Category) throws {
        guard let date = category.date else {
            // in case date is not valid
            throw CoreDataManagerErrors.noRecord
        }
        
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", argumentArray: [date as CVarArg])
        do {
            if let existingRecord = try CoreDataStack.shared.context.fetch(fetchRequest).first {
                CoreDataStack.shared.context.delete(existingRecord)
                try CoreDataStack.shared.saveContext()
            } else {
                throw CoreDataManagerErrors.noRecord
            }
        } catch {
            throw CoreDataManagerErrors.save
        }
    }
}

extension CoreDataCategoryService {
    func fetchCategory(for category: Category) throws -> CategoryEntity {
        let fetchRequest: NSFetchRequest<CategoryEntity> = CategoryEntity.fetchRequest()
        guard let date = category.date else {
            throw CategoryServiceErrors.fetch
        } 
        fetchRequest.predicate = NSPredicate(format: "date == %@", argumentArray: [date as CVarArg])
        do {
            let items = try CoreDataStack.shared.context.fetch(fetchRequest)
            guard let item = items.first else {
                throw CategoryServiceErrors.noRecord
            }
            return item
        } catch {
            throw CategoryServiceErrors.fetch
        }
    }
}
