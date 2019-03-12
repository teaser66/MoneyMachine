//
//  TransactionManager.swift
//  Money Machine
//
//  Created by Rob Faiella on 3/10/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import UIKit

class TransactionManager: NSObject {

    /// Creates transaction object - Returns true on success
    /// - parameter userId: String
    /// - parameter transactionDate: Date
    /// - parameter transactionDescription: String
    /// - parameter transactionAmount: Decimal
    /// - parameter category: String
    /// - parameter type: String
    class func createTransaction(userId:String, transactionDate:Date, transactionDescription:String, transactionAmount:Decimal, category:String, type:String) -> Bool {
        
        // Create object
        let myTransaction = TransactionObject(userId: userId, transactionDate: transactionDate, transactionDescription: transactionDescription, transactionAmount: transactionAmount, category: category, type: type)
        
        return DataManager.saveTransaction(transaction: myTransaction)
        
    }
    
    /// Combines Transaction Objects sharing the same userId - Returns Array
    /// - parameter results: [TransactionObject]
    class func combineResults(results: [TransactionObject]) -> [TransactionObject] {
    
        var returnArray:[TransactionObject] = []
        
        // Create array of distinct users
        let uniqueUsersArray = results.unique{$0.userId}
        
        // Loop through objects
        for userObject in uniqueUsersArray {
            
            var newObject:TransactionObject?
            
            // Filter array to create new array with just the current userId
            let thisUserArray = results.filter({$0.userId == userObject.userId})
            
            // Loop through this users transactions and combine them to one object
            for aObject in thisUserArray {
                
                // Check if object is created yet
                if let _ = newObject {
                    // If yes, add to it
                    
                    // Append categories if not already listed
                    let currentCategories = newObject?.category
                    if (currentCategories?.contains(aObject.category))! {
                        // Don't add it
                    }else {
                        newObject?.category = ("\(newObject?.category ?? ""), \(aObject.category)")
                    }
                    
                    // Total expenses and savings
                    if aObject.type == "Expense" {
                        let total = newObject?.totalExpense ?? 0.0
                        newObject?.totalExpense = total + aObject.transactionAmount
                    }else {
                        let total = newObject?.totalSaving ?? 0.0
                        newObject?.totalSaving = total + aObject.transactionAmount
                    }
                    
                }else {
                    // If no, create it
                    let mObject = (TransactionObject(userId: aObject.userId, transactionDate: aObject.transactionDate, transactionDescription: aObject.transactionDescription, transactionAmount: aObject.transactionAmount, category: aObject.category, type: aObject.type))
                    
                    // Set initial values
                    if aObject.type == "Expense" {
                        mObject.totalExpense = aObject.transactionAmount
                    }else {
                        mObject.totalSaving = aObject.transactionAmount
                    }
                    newObject = mObject
                }
            }
            
            returnArray.append(newObject!)
            
        }
        
        return returnArray
        
    }
    
}
