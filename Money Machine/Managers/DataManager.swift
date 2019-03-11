//
//  DAtaManager.swift
//  Money Machine
//
//  Created by Rob Faiella on 3/10/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {

    // Transaction functions
    
    class func saveTransaction(transaction: TransactionObject)  -> Bool{
        
        //Save to Core Data
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        // Context
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // Entity
        let entity =
            NSEntityDescription.entity(forEntityName: "Transaction",
                                       in: managedContext)!
        
        let transactionToSave = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // Set attributes
        transactionToSave.setValue(transaction.userId, forKeyPath: "userId")
        transactionToSave.setValue(transaction.transactionDate, forKeyPath: "date")
        transactionToSave.setValue(transaction.transactionAmount, forKeyPath: "amount")
        transactionToSave.setValue(transaction.category, forKeyPath: "category")
        transactionToSave.setValue(transaction.transactionDescription, forKeyPath: "transactionDescription")
        
        // Save
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return true
    }
    
    
    // Get functions
    
    class func transactionCategories()  -> [String]{
        
        var categories:[String] = []
        let categoryEntities = DataManager.getEntities(name:"Category")
        
        for category in categoryEntities {
            
            if let name = category.value(forKeyPath: "name") {
                categories.append((name as? String)!)
            }
            
        }
        
        return categories
    }
    
    
    class func transactionUsers()  -> [String]{
        
        var users:[String] = []
        let userEntities = DataManager.getEntities(name:"User")
        
        for user in userEntities {
            
            if let userId = user.value(forKeyPath: "userId") {
                users.append((userId as? String)!)
            }
            
        }
        
        return users
    }
    
    
    // Add functions
    
    class func addCategory(category: String) -> Bool {
        
        
        //Save to Core Data
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        // Context
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // Entity
        let entity =
            NSEntityDescription.entity(forEntityName: "Category",
                                       in: managedContext)!
        
        let categoryToSave = NSManagedObject(entity: entity,
                                                insertInto: managedContext)
        
        // Set attributes
        categoryToSave.setValue(category, forKeyPath: "name")
        
        // Save
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return true
    }
    
    
    class func addUser(category: String) -> Bool {
        //Save to Core Data
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        // Context
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // Entity
        let entity =
            NSEntityDescription.entity(forEntityName: "User",
                                       in: managedContext)!
        
        let userToSave = NSManagedObject(entity: entity,
                                             insertInto: managedContext)
        
        // Set attributes
        userToSave.setValue(category, forKeyPath: "userId")
        
        // Save
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return true
        
    }
    
    
    
    // Common functions
    
    
    class func getEntities(name: String) -> [NSManagedObject] {
        
        var entities:[NSManagedObject] = []
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return entities
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // Request
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: name)
        
        // Get It
        do {
            entities = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
       return entities
        
    }
    
}
