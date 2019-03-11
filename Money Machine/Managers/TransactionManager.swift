//
//  TransactionManager.swift
//  Money Machine
//
//  Created by Rob Faiella on 3/10/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import UIKit

class TransactionManager: NSObject {

    class func createTransaction(userId:String, transactionDate:Date, transactionDescription:String, transactionAmount:Decimal, category:String, type:String) -> Bool {
        
        let myTransaction = TransactionObject(userId: userId, transactionDate: transactionDate, transactionDescription: transactionDescription, transactionAmount: transactionAmount, category: category, type: type)
        
        return DataManager.saveTransaction(transaction: myTransaction)
        
    }
    
}
