//
//  CoreDataAccountService.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation
import CoreData

struct CoreDataAccountService: AccountService {
    /// Method: Add an account to core data entity
    /// Parameters: Account
    /// Returns: none
    func addAccount(account: Account) throws {
        let entity = NSEntityDescription.entity(forEntityName: "AccountEntity", in: CoreDataStack.shared.context)!
        let accountEntity = AccountEntity(entity: entity, insertInto: CoreDataStack.shared.context)
        accountEntity.balance = account.balance ?? 0.0
        accountEntity.id = account.id.uuidString
        accountEntity.title = account.title
        accountEntity.currency = account.currency?.rawValue
        accountEntity.notes = account.notes
        
        do {
            try CoreDataStack.shared.saveContext()
        } catch {
            throw AccountServiceErrors.addEdit
        }
    }
    
    /// Method: Add an account to core data entity
    /// Parameters: none
    /// Returns: Accounts
    
    func fetchAccounts() throws -> Accounts {
        let fetchRequest: NSFetchRequest<AccountEntity> = AccountEntity.fetchRequest()
        do {
            let items = try CoreDataStack.shared.context.fetch(fetchRequest)
            return items.map {
                Account(
                    balance: $0.balance,
                    title: $0.title,
                    currency: Currency(rawValue: $0.currency ?? StringConstants.AppConstants.inrCurrency),
                    notes: $0.notes)
            }
        } catch {
            throw AccountServiceErrors.fetch
        }
    }
    
    /// Method: Edit selected account and save it to core data entity
    /// Parameters: Account
    /// Returns: none
    func editAccount(account: Account) throws {
        let fetchRequest: NSFetchRequest<AccountEntity> = AccountEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", argumentArray: [account.id as CVarArg])
        
        do {
            if let existingRecord = try CoreDataStack.shared.context.fetch(fetchRequest).first {
                existingRecord.balance = account.balance ?? 0.0
                existingRecord.id = account.id.uuidString
                existingRecord.title = account.title
                existingRecord.currency = account.currency?.rawValue
                existingRecord.notes = account.notes
                try CoreDataStack.shared.saveContext()
            } else {
                throw AccountServiceErrors.noRecord
            }
        } catch {
            throw AccountServiceErrors.addEdit
        }
    }
    
    /// Method: Delete the selected account from core data entity
    /// Parameters: Account
    /// Returns: none
    func deleteAccount(account: Account) throws {
        guard let title = account.title else { throw CoreDataManagerErrors.noRecord
        }
        let fetchRequest: NSFetchRequest<AccountEntity> = AccountEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", argumentArray: [title as CVarArg])
        
        do {
            if let existingRecord = try CoreDataStack.shared.context.fetch(fetchRequest).first {
                CoreDataStack.shared.context.delete(existingRecord)
                try CoreDataStack.shared.saveContext()
            } else {
                throw AccountServiceErrors.noRecord
            }
        } catch {
            throw AccountServiceErrors.addEdit
        }
    }
}

extension CoreDataAccountService {
    func fetchAccount(for id: String) throws -> AccountEntity {
        let fetchRequest: NSFetchRequest<AccountEntity> = AccountEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", argumentArray: [id as CVarArg])
        
        do {
            let items = try CoreDataStack.shared.context.fetch(fetchRequest)
            guard let item = items.first else {
                throw AccountServiceErrors.noRecord
            }
            
            return item
        } catch {
            throw AccountServiceErrors.fetch
        }
    }
}
