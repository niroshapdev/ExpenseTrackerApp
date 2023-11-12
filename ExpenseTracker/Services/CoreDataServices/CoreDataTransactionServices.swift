//
//  CoreDataTransactionServices.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 16/10/23.
//

import Foundation
import CoreData

struct CoreDataTransactionService: TransactionService {
    
    /// Method: Add an Transaction to core data entity
    /// Parameters: Transaction
    /// Returns: none
    func addTransaction(transaction: Transaction) throws {
        let entity = NSEntityDescription.entity(forEntityName: "TransactionEntity", in: CoreDataStack.shared.context)!
        
        var account: AccountEntity?
        do {
            account = try CoreDataAccountService.init().fetchAccount(for: transaction.account?.title ?? "")
        } catch {
            throw AccountServiceErrors.fetch
        }
        
        guard let transactionCategory = transaction.category else {
            throw CategoryServiceErrors.noRecord
        }
        
        do {
            let category = try CoreDataCategoryService().fetchCategory(for: transactionCategory)
            let transactionEntity = TransactionEntity(entity: entity, insertInto: CoreDataStack.shared.context)
            transactionEntity.amount = transaction.amount ?? 0.0
            transactionEntity.id = transaction.id.uuidString
            transactionEntity.date = transaction.date
            transactionEntity.type = transaction.type?.rawValue ?? "Debit"
            transactionEntity.notes = transaction.notes
            transactionEntity.category = category
            transactionEntity.status = transaction.status?.rawValue
            transactionEntity.account = account
            transactionEntity.updatedBalance = transaction.updatedBalance
            
            do {
                try CoreDataStack.shared.saveContext()
            } catch {
                throw TransactionServiceErrors.addEdit
            }
        } catch {
            throw CategoryServiceErrors.fetch
        }
    }
    
    /// Method: Add an Transaction to core data entity
    /// Parameters: none
    /// Returns: Transactions
    func fetchTransactions() throws -> Transactions {
        let fetchRequest: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        do {
            let items = try CoreDataStack.shared.context.fetch(fetchRequest)
            return items.map {
                Transaction(type: TransactionType(rawValue: $0.type ?? "Debit"),
                            account:  Account(
                                balance: $0.account?.balance ?? 0.0,
                                title: $0.account?.title ?? "",
                                currency: Currency(
                                    rawValue: $0.account?.currency ?? StringConstants.AppConstants.inrCurrency),
                                notes: $0.account?.notes ?? ""
                            ),
                            category: Category(
                                id: $0.category?.id?.toUUID() ?? UUID(),
                                title: $0.category?.title ?? "",
                                color: $0.category?.color ?? "",
                                icon: $0.category?.icon ?? "", 
                                type: CategoryType(
                                    rawValue: $0.category?.type ??
                                    StringConstants.TodayViewConstants.income),
                                date: $0.category?.date ?? Utils.formatDate(date: .now)
                            ),
                            amount: $0.amount, date: $0.date,
                            status: PaymentStatus(rawValue: $0.status ?? PaymentStatus.planned.rawValue),
                            notes: $0.notes,
                            updatedBalance: $0.updatedBalance)
            }
        } catch {
            throw TransactionServiceErrors.fetch
        }
    }
    
    func fetchTransactions(for account: Account) throws -> Transactions {
        let fetchRequest: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        if let accountTitle = account.title {
            let predicate = NSPredicate(format: "account.title == %@", accountTitle)
            fetchRequest.predicate = predicate
        } else {
            throw CoreDataManagerErrors.fetch
        }
        do {
            let items = try CoreDataStack.shared.context.fetch(fetchRequest)
            return items.map {
                Transaction(type: TransactionType(rawValue: $0.type ?? "Debit"),
                            account:  Account(
                                balance: $0.account?.balance ?? 0.0,
                                title: $0.account?.title ?? "",
                                currency: Currency(rawValue: 
                                                    $0.account?.currency
                                                   ?? StringConstants.AppConstants.inrCurrency),
                                notes: $0.account?.notes ?? ""
                            ),
                            category: Category(
                                id: $0.category?.id?.toUUID() ?? UUID(),
                                title: $0.category?.title ?? "",
                                color: $0.category?.color ?? "",
                                icon: $0.category?.icon ?? "", 
                                type: CategoryType(rawValue: 
                                                    $0.category?.type ?? StringConstants.TodayViewConstants.income),
                                date: $0.category?.date ?? Utils.formatDate(date: .now)
                            ),
                            amount: $0.amount, date: $0.date,
                            status: PaymentStatus(rawValue: $0.status ?? PaymentStatus.planned.rawValue),
                            notes: $0.notes,
                            updatedBalance: $0.updatedBalance)
            }
        } catch {
            throw TransactionServiceErrors.fetch
        }
    }
    
    /// Method: Edit selected Transaction and save it to core data entity
    /// Parameters: Transaction
    /// Returns: none
    func editTransaction(transaction: Transaction) throws {
        guard let date = transaction.date else {
            throw CategoryServiceErrors.fetch
        }
        
        let fetchRequest: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date == %@", argumentArray: [date as CVarArg])
        do {
            if let existingRecord = try CoreDataStack.shared.context.fetch(fetchRequest).first {
                guard let categoryRecord = transaction.category else {
                    throw CoreDataManagerErrors.fetch
                }
                let category = try CoreDataCategoryService().fetchCategory(for: categoryRecord)
                
                guard let accountRecord = transaction.account else {
                    throw CoreDataManagerErrors.fetch
                }
                let account = try CoreDataAccountService().fetchAccount(for: accountRecord.title ?? "")
                
                existingRecord.amount = transaction.amount ?? 0.0
                existingRecord.date = transaction.date
                existingRecord.type = transaction.type?.rawValue ?? "Debit"
                existingRecord.notes = transaction.notes
                existingRecord.status = transaction.status?.rawValue
                existingRecord.category = category
                existingRecord.account = account
                try CoreDataStack.shared.saveContext()
            } else {
                throw TransactionServiceErrors.noRecord
            }
        } catch {
            throw TransactionServiceErrors.addEdit
        }
    }

    /// Method: Delete the selected Transaction from core data entity
    /// Parameters: Transaction
    /// Returns: none
    func deleteTransaction(transaction: Transaction) throws {
        let fetchRequest: NSFetchRequest<TransactionEntity> = TransactionEntity.fetchRequest()
        if let date = transaction.date {
            fetchRequest.predicate = NSPredicate(format: "date == %@", argumentArray: [date as CVarArg])
        } else {
            throw CoreDataManagerErrors.fetch
        }
        do {
            if let existingRecord = try CoreDataStack.shared.context.fetch(fetchRequest).first {
                CoreDataStack.shared.context.delete(existingRecord)
                try CoreDataStack.shared.saveContext()
            } else {
                throw CoreDataManagerErrors.noRecord
            }
        } catch {
            throw TransactionServiceErrors.delete
        }
    }
}
