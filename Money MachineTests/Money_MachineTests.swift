//
//  Money_MachineTests.swift
//  Money MachineTests
//
//  Created by Rob Faiella on 3/9/19.
//  Copyright © 2019 robfaiella. All rights reserved.
//

import XCTest
@testable import Money_Machine

class Money_MachineTests: XCTestCase {
    
    var transactionObject: TransactionObject!
    var transactionObject2: TransactionObject!
    var transactionObject3: TransactionObject!
    
    var objectsArray:[TransactionObject] = []

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
   
        // Create an object:
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let date = dateFormatter.date(from: "2019-03-11") // replace Date String
        
        transactionObject = TransactionObject(userId: "test_user", transactionDate: date!, transactionDescription: "Test Case 2", transactionAmount: 1.23, category: "Health", type: "Expense")
        
        transactionObject2 = TransactionObject(userId: "test_user", transactionDate: date!, transactionDescription: "Test Case 2", transactionAmount: 2.34, category: "Auto", type: "Expense")
        
        transactionObject3 = TransactionObject(userId: "test_user2", transactionDate: date!, transactionDescription: "Test Case 2", transactionAmount: 4.56, category: "Food", type: "Expense")
        
        objectsArray.append(transactionObject)
        objectsArray.append(transactionObject2)
        objectsArray.append(transactionObject3)
    
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        transactionObject = nil
        transactionObject2 = nil
        transactionObject3 = nil
        objectsArray = []
    }

    func testTransactionObjectIsCreated() {
        
        // 1. given
        let targetUserId = "test_user"
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let date = dateFormatter.date(from: "2019-03-11") // replace Date String
        
        let targetDate = date
        let targetDescription = "Test Case 1"
        let targetAmount = 1.23
        let targetCategory = "Health"
        let targetType = "Expense"
        
        // 2. when
        let  actualUserId = transactionObject.userId
        let  actualDate = transactionObject.transactionDate
        let  actualDescription = transactionObject.transactionDescription
        let  actualAmount = transactionObject.transactionAmount
        let  actualCategory = transactionObject.category
        let  actualType = transactionObject.type
        
        // 3. then
        XCTAssertEqual(actualUserId, targetUserId, "User Id is not \"test_user\"")
        XCTAssertEqual(actualDate, targetDate, "Date is not \"2019-03-11\"")
        XCTAssertEqual(actualDescription, targetDescription, "Description is not \"Test Case 1\"")
        XCTAssertEqual(actualAmount, Decimal(targetAmount), "Amount is not 1.23")
        XCTAssertEqual(actualCategory, targetCategory, "Category is not \"Health\"")
        XCTAssertEqual(actualType, targetType, "Type is not \"Expense\"")
    }
    
    func testCombineObjects() {
        
        // 1. given
        let targetUserId = "test_user"
        let targetAmount:Decimal = Decimal(string: "3.57")! //1.23 + 2.34
        let targetCategory = "Health, Auto"
        
        // 2. when
        let  combinedObjectArray = ReportsViewController.combineResults(results: objectsArray)
        
        var combinedObject:TransactionObject?
        for object in combinedObjectArray {
            if object.userId == "test_user" {
                combinedObject = object
                break
            }
        }
        
        let  actualUserId = combinedObject?.userId
        let  actualAmount = combinedObject?.totalExpense
        let  actualCategory = combinedObject?.category
        
        
        
        // 3. then
        XCTAssertEqual(actualUserId, targetUserId, "User Id is not \"test_user\"")
        XCTAssertEqual(actualAmount, targetAmount, "Amount is not 3.57")
        XCTAssertEqual(actualCategory, targetCategory, "Category is not \"Health, Auto\"")
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
