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
        transactionToSave.setValue(transaction.type, forKeyPath: "type")
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
    
    
    // Search Functions
    
    
    class func searchForItWith(attributes: Dictionary<String, Any>) -> [TransactionObject] {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            let fetchRequest : NSFetchRequest<Transaction> = Transaction.fetchRequest()
            
            //Build predicate
            var predicateArray:[NSPredicate] = []
            
            if let theRange = attributes["range"] as? String {
                if theRange == "day" {
                    predicateArray.append(NSPredicate(format: "%K >= %@ && %K <= %@", "date", DataManager.getThisDayStart()! as NSDate, "date", DataManager.getThisDayEnd()! as NSDate))
                }
                if theRange == "week" {
                    predicateArray.append(NSPredicate(format: "%K >= %@ && %K <= %@", "date", DataManager.getThisWeekStart()! as NSDate, "date", DataManager.getThisWeekEnd()! as NSDate))
                }
                if theRange == "month" {
                    predicateArray.append(NSPredicate(format: "%K >= %@ && %K <= %@", "date", DataManager.getThisMonthStart()! as NSDate, "date", DataManager.getThisMonthEnd()! as NSDate))
                }
                if theRange == "year" {
                    predicateArray.append(NSPredicate(format: "%K >= %@ && %K <= %@", "date", DataManager.getThisYearStart()! as NSDate, "date", DataManager.getThisYearEnd()! as NSDate))
                }
            }else {
                if let theUser = attributes["userId"] as? String {
                    predicateArray.append(NSPredicate(format: "userId = %@", theUser))
                }
                if let theCategory = attributes["category"] as? String {
                    predicateArray.append(NSPredicate(format: "category = %@", theCategory))
                }
                if let theDate = attributes["date"] as? Date {
                    predicateArray.append(NSPredicate(format: "date = %@", theDate as CVarArg))
                }
                if let theType = attributes["type"] as? String {
                    predicateArray.append(NSPredicate(format: "type = %@", theType))
                }
            }
            
            
            let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicateArray)
            print(predicate)
            fetchRequest.predicate = predicate
            let fetchedResults = try context.fetch(fetchRequest)
            var results:[TransactionObject] = []
            for transaction in fetchedResults {
                let object = TransactionObject(userId: transaction.userId ?? "", transactionDate: transaction.date!, transactionDescription: transaction.transactionDescription ?? "" , transactionAmount: transaction.amount! as Decimal, category: transaction.category ?? "", type: transaction.type ?? "")
                results.append(object)
            }
            
            return results
        }
        catch {
            print ("fetch task failed", error)
        }
        
        return []
        
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
    
    
    class func addUser(name: String) -> Bool {
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
        userToSave.setValue(name, forKeyPath: "userId")
        
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
    
    
    // Helpers
    
    class func textIsValidCurrencyFormat(text: String) -> Bool {
        var isValidCurrencyFormat = false
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let number = numberFormatter.number(from: text)
        
        if number != nil {
            let numberParts = text.components(separatedBy: ".")
            if numberParts.count == 2 {
                let decimalArray = Array(numberParts[1])
                if decimalArray.count <= 2 {
                    if text == text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) {
                        isValidCurrencyFormat = true
                    }
                }
            } else {
                if text == text.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) {
                    isValidCurrencyFormat = true
                }
            }
            
        }
        
        return isValidCurrencyFormat
    }
    
    
   
    
    class func getThisDayStart() -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        return calendar.startOfDay(for: Date())
    }
    
    class func getThisDayEnd() -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        return calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: Date()))
    }
    
    class func getThisMonthStart() -> Date? {
        let components = Calendar.current.dateComponents([.year, .month], from: Date())
        return Calendar.current.date(from: components)!
    }
    
    class func getThisMonthEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year, .month], from: Date()) as NSDateComponents
        components.month += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    
    
    class func getThisWeekStart() -> Date? {
        let components = Calendar.current.dateComponents([.year, .month, .weekday], from: getThisDayStart() ?? Date()) as NSDateComponents
        let theDiff = components.weekday - 1
        print(Calendar.current.date(byAdding: .day, value: -theDiff, to: getThisDayStart() ?? Date())!)
        return Calendar.current.date(byAdding: .day, value: -theDiff, to: getThisDayStart() ?? Date())
    }
    
    class func getThisWeekEnd() -> Date? {
        let components = Calendar.current.dateComponents([.year, .month, .weekday], from: getThisDayEnd() ?? Date()) as NSDateComponents
        let theDiff = 7 - components.weekday
        print(Calendar.current.date(byAdding: .day, value: theDiff, to: getThisDayStart() ?? Date())!)
        return Calendar.current.date(byAdding: .day, value: theDiff, to: getThisDayStart() ?? Date())
    }
    
    class func getThisYearStart() -> Date? {
        let components = Calendar.current.dateComponents([.year], from: Date())
        return Calendar.current.date(from: components)!
    }
    
    class func getThisYearEnd() -> Date? {
        let components:NSDateComponents = Calendar.current.dateComponents([.year], from: Date()) as NSDateComponents
        components.year += 1
        components.day = 1
        components.day -= 1
        return Calendar.current.date(from: components as DateComponents)!
    }
    

    
}
