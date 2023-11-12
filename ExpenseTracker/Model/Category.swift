//
//  Category.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation

public typealias Categories = [Category]

public enum CategoryType: String, CaseIterable {
    case income = "Income"
    case expense = "Expense"
}

public struct Category {
    var id: UUID
    var title: String?
    var color: String?
    var icon: String?
    var type: CategoryType?
    var date: Date?
    
    public init(id: UUID = UUID(), title: String?, color: String?, icon: String?, type: CategoryType?, date: Date) {
        self.id = id
        self.title = title
        self.color = color
        self.icon = icon
        self.type = type
        self.date = date
    }
    
    public init(title: String?, color: String?, icon: String?, type: CategoryType?, date: Date) {
        self.id = UUID()
        self.title = title
        self.color = color
        self.icon = icon
        self.type = type
        self.date = date
    }
}

extension Category: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
}
