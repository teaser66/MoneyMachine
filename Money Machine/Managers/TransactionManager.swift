//
//  TransactionManager.swift
//  Money Machine
//
//  Created by Rob Faiella on 3/10/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import UIKit

class TransactionManager: NSObject {

    public func createTransaction(userId:String, transactionDate:Date, transactionDescription:String, transactionAmount:Decimal, category:String) -> Bool {
        
        let myTransaction = TransactionObject(userId: userId, transactionDate: transactionDate, transactionDescription: transactionDescription, transactionAmount: transactionAmount, category: category)
        
        return DataManager.saveTransaction(transaction: myTransaction)
        
    }
    
}
