//
//  Goal.swift
//  ExpenseTracker
//
//  Created by Nirosha Pabolu on 17/10/23.
//

import Foundation

public typealias Goals = [Goal]

public struct Goal {
    var id: UUID
    var title: String?
    var targetAmount: Double?
    var savedAmount: Double?
    var currency: String?
    
    public init(id: UUID = UUID(), 
                title: String? = "",
                targetAmount: Double? = 0.0,
                savedAmount: Double? = 0.0,
                currency: String? = StringConstants.AppConstants.inrCurrency) {
        self.id = id
        self.title = title
        self.targetAmount = targetAmount
        self.savedAmount = savedAmount
        self.currency = currency
    }
}
