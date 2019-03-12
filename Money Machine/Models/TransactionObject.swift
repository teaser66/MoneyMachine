//
//  TransactionObject.swift
//  Money Machine
//
//  Created by Rob Faiella on 3/10/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import UIKit

public class TransactionObject: NSObject {
    
    public var userId:String
    public var transactionDate:Date
    public var transactionDescription:String
    public var transactionAmount:Decimal
    public var category:String
    public var type:String
    public var totalExpense:Decimal
    public var totalSaving:Decimal
   
    public init(userId:String, transactionDate:Date, transactionDescription:String, transactionAmount:Decimal, category:String, type:String) {
        self.userId = userId
        self.transactionDate = transactionDate
        self.transactionDescription = transactionDescription
        self.transactionAmount = transactionAmount
        self.category = category
        self.type = type
        self.totalExpense = 0.0
        self.totalSaving = 0.0
    }
    
   
   
    
}
